import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms/Module/utils/logger.dart';
import 'package:fms/compass/compass_viewmodel.dart';
import 'package:fms/constants/app_colors.dart';
import 'package:fms/Module/utils/swipe_back_detector.dart';
import 'package:provider/provider.dart';
import 'package:fms/l10n/app_localizations.dart';

class CompassView extends StatelessWidget {
  final String placeName;
  final double targetLat;
  final double targetLng;

  const CompassView({
    super.key,
    required this.placeName,
    required this.targetLat,
    required this.targetLng,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          CompassViewModel(targetLat: targetLat, targetLng: targetLng),
      child: Scaffold(
        backgroundColor: const Color(0xFFE8FCEF), // 연한 민트색 배경
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.compassTitle,
            style: TextStyle(
              color: AppColors.forestGreen,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.forestGreen),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
        ),
        body: SwipeBackDetector(
          child: Consumer<CompassViewModel>(
            builder: (context, vm, child) {
              // 화면에 보여질 나침반 회전각 (디바이스 헤딩 반대 방향)
              final compassRotation = vm.heading == null
                  ? 0.0
                  : -vm.heading! * (math.pi / 180);

              // 목적지 화살표 회전각 (나침반 회전각 + 목적지 방위각)
              final bearingRotation = vm.bearing == null
                  ? 0.0
                  : vm.bearing! * (math.pi / 180);
              final arrowRotation = compassRotation + bearingRotation;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                child: Column(
                  children: [
                    // 상단 카드 (장소 정보)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(50),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            placeName,
                            style: TextStyle(
                              color: AppColors.forestGreen,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            AppLocalizations.of(context)!.distanceAndDirection,
                            style: TextStyle(
                              color: const Color(0xFF8E9B8E),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Spacer(),

                    // 나침반 UI
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // 나침반 판 (N/E/S/W)
                        Transform.rotate(
                          angle: compassRotation,
                          child: Container(
                            width: 300.w,
                            height: 300.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(50),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                              border: Border.all(
                                color: const Color(0xFFE0EBE0),
                                width: 10,
                              ),
                            ),
                            child: Stack(
                              children: [
                                // 눈금들
                                ...List.generate(12, (index) {
                                  return Transform.rotate(
                                    angle: (index * 30) * (math.pi / 180),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 5),
                                        width: 2,
                                        height: index % 2 == 0 ? 15 : 10,
                                        color: const Color(0xFFBAC7BA),
                                      ),
                                    ),
                                  );
                                }),

                                // N
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'N',
                                      style: TextStyle(
                                        color: AppColors.forestGreen,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                // S
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'S',
                                      style: TextStyle(
                                        color: AppColors.forestGreen,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                // E
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'E',
                                      style: TextStyle(
                                        color: AppColors.forestGreen,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                // W
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'W',
                                      style: TextStyle(
                                        color: AppColors.forestGreen,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 중앙 화살표
                        Transform.rotate(
                          angle: arrowRotation,
                          child: Icon(
                            Icons.navigation_rounded,
                            size: 80.w,
                            color: AppColors.forestGreen,
                          ),
                        ),
                      ],
                    ),

                    Spacer(),

                    // 하단 정보 (거리)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(50),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            vm.formatDistance(vm.distance),
                            style: TextStyle(
                              color: AppColors.forestGreen,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            AppLocalizations.of(context)!.distanceToDest,
                            style: TextStyle(
                              color: const Color(0xFF8E9B8E),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // 정확도 표시
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            vm.accuracy != null
                                ? AppLocalizations.of(context)!.accuracyLabel(
                                    vm.accuracy!.toStringAsFixed(0),
                                  )
                                : AppLocalizations.of(context)!.gpsSearching,
                            style: TextStyle(
                              color: const Color(0xFF6B8166),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (vm.accuracy != null) ...[
                            SizedBox(height: 4.h),
                            Text(
                              AppLocalizations.of(context)!.accuracyWarning,
                              style: TextStyle(
                                color: const Color(0xFFA0B0A0),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
