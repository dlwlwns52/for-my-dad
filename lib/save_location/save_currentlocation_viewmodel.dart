import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fms/Module/db/hive_Service.dart';
import 'package:fms/Module/db/hive_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class SaveCurrentLocationViewModel extends ChangeNotifier {
  final SpotService _spotService = SpotService();

  File? selectedImage;
  List<File> selectedImages = [];
  bool isSaving = false;

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      selectedImages.addAll(pickedFiles.map((x) => File(x.path)).toList());
      notifyListeners();
    }
  }

  Future<void> pickCamera() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      selectedImages.add(File(picked.path));
      notifyListeners();
    }
  }

  void removeImageAt(int index) {
    selectedImages.removeAt(index);
    notifyListeners();
  }

  Future<void> saveCurrentSpot({
    required String placeName,
    String? memo,
  }) async {
    final trimmedName = placeName.trim();
    if (trimmedName.isEmpty || isSaving) return;

    isSaving = true;
    notifyListeners();

    try {
      final position = await _determinePosition();
      final memoText = memo?.trim();
      final imagePaths = selectedImages.isEmpty
          ? null
          : selectedImages.map((file) => file.path).toList();

      final spot = Spot(
        placeName: trimmedName,
        memo: memoText?.isEmpty ?? true ? null : memoText,
        imagePath: imagePaths,
        latitude: position.latitude,
        longitude: position.longitude,
      );

      await _spotService.addSpot(spot);
      selectedImages.clear();
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("위치 서비스가 꺼져 있습니다.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("위치 권한이 거부되었습니다.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("위치 권한을 설정에서 허용해야 합니다.");
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }
}
