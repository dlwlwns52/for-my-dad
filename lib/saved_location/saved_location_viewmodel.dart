// import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fms/Module/db/hive_Service.dart';
import 'package:fms/Module/db/hive_model.dart';
import 'package:fms/Module/utils/logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fms/Module/location/location_service.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';

class SavedLocationViewmodel extends ChangeNotifier {
  final SpotService _spotService;

  SavedLocationViewmodel(this._spotService);

  Position? currentPosition;

  //MARK: 현재 위치 가져오기
  Future<void> getCurrentPosition() async {
    try {
      currentPosition = await LocationService().getCurrentPosition();
      notifyListeners();
    } catch (e) {
      printDebug("위치 가져오기 실패: $e");
      // 필요하다면 에러 처리를 추가하세요. 기존 로직은 예외를 던졌으나, void 함수라 무시되었을 수 있음.
    }
  }

  String calculateDistance(Spot spot) {
    if (currentPosition == null) return "위치 확인 중...";

    final distance = Geolocator.distanceBetween(
      spot.latitude,
      spot.longitude,
      currentPosition!.latitude,
      currentPosition!.longitude,
    );
    if (distance < 1000) {
      return "${distance.toStringAsFixed(1)}m";
    } else {
      return "${(distance / 1000).toStringAsFixed(1)}km";
    }
  }
}
