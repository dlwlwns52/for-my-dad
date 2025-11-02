import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class SaveCurrentLocationViewModel extends ChangeNotifier {
  File? selectedImage;
  List<File> selectedImages = [];

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
}

// Future<void> _getCurrentPosition() async {
//   // 권한 체크 & 요청
//   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // GPS 자체가 꺼져 있음
//     print("위치 서비스가 꺼져 있습니다.");
//     return;
//   }

//   LocationPermission permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       print("위치 권한이 거부되었습니다.");
//       return;
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     print("위치 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해야 합니다.");
//     return;
//   }

//   // 현재 위치 가져오기
//   Position position = await Geolocator.getCurrentPosition(
//     locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
//   );

//   print("현재 위치: 위도 ${position.latitude}, 경도 ${position.longitude}");
// }
