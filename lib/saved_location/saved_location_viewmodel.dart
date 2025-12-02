// import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fms/Module/db/hive_Service.dart';
import 'package:fms/Module/db/hive_model.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';

class SavedLocationViewmodel extends ChangeNotifier {
  final SpotService _spotService;

  SavedLocationViewmodel(this._spotService);

  Position? currentPosition;

  //MARK: 현재 위치 가져오기
  Future<void> getCurrentPosition() async {
    //MARK: 권한 체크 & 요청
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //MARK: GPS 자체가 꺼져 있음
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
      throw Exception("위치 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해야 합니다.");
    }

    //MARK: 현재 위치 가져오기
    currentPosition = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
    );
    debugPrint(
      "현재 위치(saved): 위도 ${currentPosition?.latitude}, 경도 ${currentPosition?.longitude}",
    );
    notifyListeners();
  }

  String calculateDistance(Spot spot) {
    if (currentPosition == null) return "이전 화면으로 갔다가 다시 들어오셈";

    final distance = Geolocator.distanceBetween(
      spot.latitude,
      spot.longitude,
      currentPosition!.latitude,
      currentPosition!.longitude,
    );
    printDebug("저장된 위치(saved): 위도 ${spot.latitude}, 경도 ${spot.longitude}");
    printDebug(
      "현재 위치(saved): 위도 ${currentPosition?.latitude}, 경도 ${currentPosition?.longitude}",
    );
    printDebug("거리 : $distance");
    if (distance < 1000) {
      return "${distance.toStringAsFixed(1)}m";
    } else {
      return "${(distance / 1000).toStringAsFixed(1)}km";
    }
  }

  //MARK: 현재 정보 저장
  Future<void> removeCurrentSpot({required int index}) async {
    if (index == 0) return;
    try {
      printDebug("removeurrentSpot 시작");
      await _spotService.deleteSpot(index);
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      printDebug("removeurrentSpot 종료됨");
      notifyListeners();
    }
  }
}
