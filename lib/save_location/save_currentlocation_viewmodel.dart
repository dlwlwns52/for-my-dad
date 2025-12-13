import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fms/Module/db/hive_Service.dart';
import 'package:fms/Module/db/hive_model.dart';
import 'package:fms/Module/utils/logger.dart';

import 'package:image_picker/image_picker.dart';
import 'package:fms/Module/location/location_service.dart';

class SaveCurrentLocationViewModel extends ChangeNotifier {
  List<File> selectedImages = [];
  final SpotService _spotService;
  SaveCurrentLocationViewModel(this._spotService);
  bool isSaving = false;

  //MARK: 이미지들 저장
  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      selectedImages.addAll(pickedFiles.map((x) => File(x.path)).toList());
      notifyListeners();
    }
  }

  //MARK: 카메라로 찍은 이미지 저장
  Future<void> pickCamera() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      selectedImages.add(File(picked.path));
      notifyListeners();
    }
  }

  //MARK: 이미지 삭제(사용자가 X 누를때 사용)
  void removeImageAt(int index) {
    selectedImages.removeAt(index);
    notifyListeners();
  }

  //MARK: 현재 정보 저장
  Future<void> saveCurrentSpot({
    required String placeName,
    String? memo,
  }) async {
    final placeText = placeName.trim();
    if (placeText.isEmpty || isSaving) return;

    isSaving = true;
    notifyListeners();

    try {
      printDebug("saveCurrentSpot 시작");
      final placeText = placeName.trim();
      String? memoText = memo?.trim();
      final trimmedMemo = (memoText?.isEmpty ?? true) ? null : memoText;

      final imagePaths = selectedImages.isEmpty
          ? null
          : selectedImages.map((file) => file.path).toList();
      final now = DateTime.now();

      final position = await LocationService().getCurrentPosition();

      final spot = Spot(
        placeName: placeText,
        memo: trimmedMemo,
        imagePath: imagePaths,
        createdAt: now,
        latitude: position.latitude,
        longitude: position.longitude,
      );

      await _spotService.addSpot(spot);
      selectedImages.clear();
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      printDebug("addSpot 종료됨");
      isSaving = false;
      notifyListeners();
    }
  }
}
