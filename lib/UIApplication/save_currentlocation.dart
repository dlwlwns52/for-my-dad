import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms/constants/app_colors.dart';
import 'package:flutter/services.dart'; // 햅틱용
import 'package:dotted_border/dotted_border.dart';

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

      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 373.w, // 디자이너가 준 너비
            maxHeight: 615.h, // 디자이너가 준 높이
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDialogHeader(context),
                SizedBox(height: 25.h),
                _buildStoreNameField(context),
                SizedBox(height: 16.h),
                _buildMemoField(context),
                SizedBox(height: 19.h),
                _buildPhotoUploadSection(context),
                SizedBox(height: 19.h),
                _buildActionButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

//MARK: 장소 이름, 입력
Widget _buildStoreNameField(BuildContext context) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(24.w, 0, 25.w, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "장소 이름",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.midiumText,
            fontFamily: "Pretendard",
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          // 입력하는 텍스트 스타일
          style: TextStyle(
            color: AppColors.midiumText,
            fontFamily: "Pretendard",
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
          ),
          cursorColor: AppColors.midiumText,
          cursorHeight: 20.0.h,
          decoration: InputDecoration(
            hintText: "장소 이름을 입력하세요",
            hintStyle: TextStyle(
              color: AppColors.forestGreen,
              fontFamily: "Pretendard",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            contentPadding: EdgeInsets.fromLTRB(12.w, 0, 23.w, 0),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: AppColors.forestGreen, // 클릭 시(포커스) 색
                width: 2, // 클릭 시(포커스) 두께
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMemoField(BuildContext context) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(24.w, 0, 25.w, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "메모 (선택사항)",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.midiumText,
            fontFamily: "Pretendard",
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          maxLines: 2,
          // 입력하는 텍스트 스타일
          style: TextStyle(
            color: AppColors.midiumText,
            fontFamily: "Pretendard",
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
          ),
          cursorColor: AppColors.midiumText,
          cursorHeight: 20.0.h,
          decoration: InputDecoration(
            hintText: "장소 이름을 입력하세요",
            hintStyle: TextStyle(
              color: AppColors.forestGreen,
              fontFamily: "Pretendard",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            contentPadding: EdgeInsets.fromLTRB(12.w, 19.h, 23.w, 0.h),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: AppColors.forestGreen, // 클릭 시(포커스) 색
                width: 2, // 클릭 시(포커스) 두께
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "0/200자",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Color(0xFF6B8166),
            fontFamily: "Pretendard",
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget _buildPhotoUploadSection(BuildContext context) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(24.w, 0, 24.w, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "사진 (선택사항)",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.midiumText,
            fontFamily: "Pretendard",
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
        DottedBorder(
          options: RoundedRectDottedBorderOptions(
            color: Color(0xFFD6E2D4),
            radius: Radius.circular(12),
            dashPattern: [6, 5], //실선 길이, 공백 길이
            strokeWidth: 3,
          ),
          child: Container(
            width: double.infinity,
            height: 130.h, // 필요 시 고정 높이
            color: const Color(0xFFF4FAF1), // 연한 초록 배경
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icon/camera.svg',
                  width: 35.w,
                  height: 35.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF6B8166),
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "사진을 추가하려면 클릭하세요",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF6B8166),
                    fontFamily: "Pretendard",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildActionButtons(BuildContext context) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(24.w, 0, 24.w, 0),
    child: Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 30.h,
            // color: AppColors.forestGreen,
            decoration: BoxDecoration(
              color: AppColors.forestGreen,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                "저장",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Pretendard",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15.h),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 30.h,
            // color: AppColors.forestGreen,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Color(0xFFE7F0E6), width: 1),
            ),
            child: Center(
              child: Text(
                "취소",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Pretendard",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
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
