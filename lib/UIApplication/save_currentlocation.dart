import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms/constants/app_colors.dart';
import 'package:flutter/services.dart'; // 햅틱용

class SaveCurrentLocation extends StatefulWidget {
  const SaveCurrentLocation({super.key});

  @override
  State<SaveCurrentLocation> createState() => _SaveCurrentLocationState();
}

class _SaveCurrentLocationState extends State<SaveCurrentLocation> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // 둥근 모서리
      ),
      insetPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 11.w),
      backgroundColor: Color(0xFFF8FDF6),
      child: Container(
        height: 615.h,
        width: 373.w,
        child: Column(children: [_buildDialogHeader(context)]),
      ),
    );
  }
}

//
//MARK: 다이어로그 헤더(제목, 소제목)
Widget _buildDialogHeader(BuildContext context) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(27.w, 20.h, 22.w, 0),
    child: Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/icon/currentSpot.svg',
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                "현재 위치를 저장하시겠습니까?",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.forestGreen,
                  fontFamily: "Pretendard",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            // SizedBox(width: 43.w),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                HapticFeedback.mediumImpact();
              },
              child: SvgPicture.asset(
                'assets/icon/x.svg',
                width: 24.w,
                height: 24.w,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(fontSize: 13.sp, color: Color(0xFF6F8469)),
            children: [
              TextSpan(
                text: "장소의 이름, 메모, 사진을 추가하여 나중에 쉽게 찾을 수 있도록",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: "저장하세요!",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
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
