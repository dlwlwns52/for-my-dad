import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SaveCurrentLocation extends StatefulWidget {
  const SaveCurrentLocation({super.key});

  @override
  State<SaveCurrentLocation> createState() => _SaveCurrentLocationState();
}

class _SaveCurrentLocationState extends State<SaveCurrentLocation> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("제목"),
      content: const Text("내용"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("취소"),
        ),
        ElevatedButton(
          onPressed: () {
            // 확인 동작
            _getCurrentPosition();
            // Navigator.pop(context);
          },
          child: const Text("현재 위치 테스트"),
        ),
      ],
    );
  }
}

Future<void> _getCurrentPosition() async {
  // 권한 체크 & 요청
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // GPS 자체가 꺼져 있음
    print("위치 서비스가 꺼져 있습니다.");
    return;
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print("위치 권한이 거부되었습니다.");
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    print("위치 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해야 합니다.");
    return;
  }

  // 현재 위치 가져오기
  Position position = await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
  );

  print("현재 위치: 위도 ${position.latitude}, 경도 ${position.longitude}");
}
