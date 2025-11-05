import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//MARK: 경고형(warning 아이콘 사용)
SnackBar customSnackBar(String message) {
  return SnackBar(
    behavior: SnackBarBehavior.floating, // 화면 아래 살짝 떠 있는 스타일
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // 여백
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // 둥근 모서리
    ),
    backgroundColor: const Color(0xFFFFF4E5), // 연한 노랑톤 배경
    elevation: 6, // 그림자
    duration: const Duration(seconds: 2),

    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.warning_amber_rounded,
          color: Color(0xFFB26A00), // 진한 주황색 아이콘
          size: 24,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF5C3B00),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
