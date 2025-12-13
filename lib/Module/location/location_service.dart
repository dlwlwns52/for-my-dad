import 'package:geolocator/geolocator.dart';
import 'package:fms/Module/utils/logger.dart';

class LocationService {
  // Singleton pattern (optional, but good for services)
  static final LocationService _instance = LocationService._internal();

  factory LocationService() {
    return _instance;
  }

  LocationService._internal();

  //MARK: 현재 위치 가져오기
  Future<Position> getCurrentPosition() async {
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
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 3,
      ),
    );

    printDebug(
      "현재 위치(Service): 위도 ${position.latitude}, 경도 ${position.longitude}",
    );
    return position;
  }
}
