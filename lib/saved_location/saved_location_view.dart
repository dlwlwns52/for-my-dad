import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms/Module/db/hive_Service.dart';
import 'package:fms/Module/utils/logger.dart';
import 'package:fms/Module/utils/snack_bar.dart';
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
                                    // 삭제
                                    _iconButton(
                                      icon: Icons.delete_outline,
                                      borderColor: const Color(0xFFD73B3B),
                                      iconColor: const Color(0xFFD73B3B),
                                      onPressed: () {
                                        showDeleteSpotDialog(
                                          context: context,
                                          spotName: spot.placeName,
                                          onConfirm: () {
                                            HapticFeedback.mediumImpact();
                                            vm.removeCurrentSpot(index: index);
                                          },
                                        );
                                      },
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
                            const SizedBox(height: 12),
                            if (spot.imagePath != null &&
                                spot.imagePath!.isNotEmpty) ...[
                              Stack(
                                children: [
                                  SizedBox(
                                    height: 150.h,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: spot.imagePath!.length,
                                      separatorBuilder: (_, _) =>
                                          const SizedBox(width: 8),
                                      itemBuilder: (context, imgIndex) {
                                        final images = spot.imagePath!;
                                        final path = images[imgIndex];

                                        return SizedBox(
                                          width: 150,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                            child: Image.file(
                                              File(path),
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                    return Container(
                                                      color: const Color(
                                                        0xFFF4FAF1,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Icon(
                                                        Icons
                                                            .image_not_supported,
                                                        color: Color(
                                                          0xFF6B8166,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  if (spot.imagePath!.length > 2) ...[
                                    Positioned(
                                      top: 5.w,
                                      right: 5.w,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(
                                            alpha: 0.3,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          '${spot.imagePath!.length}장',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
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

// 삭제 여부 물어보는 다이어로그
Future<void> showDeleteSpotDialog({
  required BuildContext context,
  required String spotName,
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FCF8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 경고 아이콘
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEFEF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFD73B3B),
                  size: 40,
                ),
              ),

              const SizedBox(height: 24),

              // 제목
              const Text(
                "장소를 삭제하시겠습니까?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E3A1E),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // 장소 이름
              Text(
                "\"$spotName\"",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF183317),
                ),
              ),

              const SizedBox(height: 8),

              // 안내 문구
              const Text(
                "이 장소를 삭제하면 복구할 수 없습니다.",
                style: TextStyle(fontSize: 14, color: Color(0xFF9CA69C)),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // 버튼 영역
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Color(0xFFDBE5DB)),
                      ),
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "취소",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF1E3A1E),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD73B3B),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        Navigator.pop(context);
                        onConfirm();
                      },
                      child: const Text(
                        "삭제",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
