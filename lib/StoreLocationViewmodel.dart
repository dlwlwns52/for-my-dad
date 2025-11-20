// import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fms/Module/db/hive_Service.dart';
import 'package:fms/Module/db/hive_model.dart';
import 'package:fms/Module/utils/logger.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';

class StoreLocationViewmodel extends ChangeNotifier {
  final SpotService _spotService;

  StoreLocationViewmodel(this._spotService);

  bool isLoading = false;
  String? error;
  List<Spot> spots = [];

  Future<void> init() async {
    await loadSpots();
  }

  Future<void> loadSpots() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      spots = await _spotService.fetchAllSpots();

      notifyListeners();
    } catch (e) {
      error = e.toString();
      printDebug("loadSpots 에러 : $e");
    } finally {
      isLoading = false;
      printDebug("loadSpots 로딩 실패");
      notifyListeners();
    }
  }

  Future<void> deleteAt(int index) async {
    try {
      await _spotService.deleteSpot(index);
      spots.removeAt(index);
      notifyListeners();
    } catch (e) {
      error = '삭제 실패: $e';
      printDebug("deleteAt 에러 : $e");
      notifyListeners();
    }
  }

  //MARK: 현재 위치 가져오기
  Future<Position> _getCurrentPosition() async {
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
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
    debugPrint("현재 위치: 위도 ${position.latitude}, 경도 ${position.longitude}");
    return position;
  }
}
