import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms/Module/db/hive_Service.dart';
import 'package:fms/Module/utils/logger.dart';
import 'package:fms/StoreLocationViewmodel.dart';
import 'package:fms/UIApplication/main_screen.dart';
import 'package:fms/constants/app_colors.dart';
import 'package:fms/saved_location/saved_location_viewmodel.dart';
import 'package:provider/provider.dart';

class SavedLocationsView extends StatelessWidget {
  const SavedLocationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          SavedLocationViewmodel(SpotService())..getCurrentPosition(),
      builder: (context, _) {
        final savedVM = context.watch<SavedLocationViewmodel>();
        return Scaffold(
          backgroundColor: AppColors.storeSpotBackground,
          appBar: AppBar(
            backgroundColor: Color(0xFFFFFFFF),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF183317)),
              onPressed: () => Navigator.pop(context),
            ),
            scrolledUnderElevation: 0,
            centerTitle: true,
            title: Text(
              '저장된 장소',
              style: TextStyle(
                color: AppColors.midiumText,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                fontFamily: 'Pretendard',
              ),
            ),
          ),

          body: Consumer<StoreLocationViewmodel>(
            builder: (context, vm, _) {
              if (vm.isLoading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.midiumText),
                );
              }
              if (vm.error != null) {
                printDebug(vm.error);
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 70.w,
                        color: Color(0xFF6B8166),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "불러오기 실패하였습니다.",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.midiumText,
                        ),
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          vm.loadSpots;
                        },
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: 50.h,
                            maxWidth: 200.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.forestGreen,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                offset: Offset(0, 2),
                                blurRadius: 4,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "다시 시도하기",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Pretendard",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 200.h),
                    ],
                  ),
                );
              }
              if (vm.spots.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 70.w,
                        color: Color(0xFF6B8166),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "저장된 장소가 없습니다",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.midiumText,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "첫 번째 비밀 장소를 저장해보세요!",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF6B8166),
                        ),
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        borderRadius: BorderRadius.circular(
                          15,
                        ), // ripple도 radius 맞춰야 자연스러움
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ),
                          );
                        },
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: 50.h,
                            maxWidth: 200.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.forestGreen,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                offset: Offset(0, 2),
                                blurRadius: 4,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "위치 저장하러 가기",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Pretendard",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 200.h),
                    ],
                  ),
                );
              }

              // }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                child: ListView.builder(
                  itemCount: vm.spots.length,
                  itemBuilder: (context, index) {
                    final spot = vm.spots[index];
                    final distance = savedVM.calculateDistance(spot);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFDBE5DB)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 제목과 버튼들
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  spot.placeName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF183317),
                                  ),
                                ),
                                Row(
                                  children: [
                                    _iconButton(
                                      icon: Icons.map,
                                      borderColor: const Color(0xFF2468E2),
                                      iconColor: const Color(0xFF2468E2),
                                      onPressed: () {},
                                    ),
                                    const SizedBox(width: 8),
                                    _iconButton(
                                      icon: Icons.navigation_outlined,
                                      borderColor: const Color(0xFF275025),
                                      iconColor: const Color(0xFF275025),
                                      onPressed: () {},
                                    ),
                                    const SizedBox(width: 8),
                                    _iconButton(
                                      icon: Icons.delete_outline,
                                      borderColor: const Color(0xFFD73B3B),
                                      iconColor: const Color(0xFFD73B3B),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text.rich(
                              TextSpan(
                                text: '거리: ',
                                style: TextStyle(
                                  color: Color(0xFF647A60),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                                children: [
                                  TextSpan(
                                    text: distance,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF183317),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text.rich(
                              TextSpan(
                                text: '저장: ',
                                style: TextStyle(
                                  color: Color(0xFF647A60),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                                children: [
                                  TextSpan(
                                    text: vm.formatDate(spot.createdAt),
                                    style: const TextStyle(
                                      color: Color(0xFF183317),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _iconButton({
    required IconData icon,
    required Color borderColor,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, color: iconColor, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}
