// class
// lib/UIApplication/main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms/StoreLocationViewmodel.dart';
import 'package:fms/save_location/save_currentlocation_view.dart';
import 'package:fms/constants/app_colors.dart';
import 'package:flutter/services.dart'; // 햅틱용
import 'package:provider/provider.dart';
import '../saved_location/saved_location_view.dart';
import 'package:fms/l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 30.h,
                  ), //Figma에서는 80인데 실 기기 사용시 30으로 수정하는게 피그마 ui랑 비슷해서 수정
                  _heroHeader(context),
                  SizedBox(height: 50.h),
                  _statCard(context),
                  SizedBox(height: 34.h),
                  _saveCurrentLocation(context),
                  SizedBox(height: 17.h),
                  _viewSavedLocations(context),
                  SizedBox(height: 50.h),
                  _tipsCard(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//MARK: 산삼 스팟 저장
Widget _heroHeader(BuildContext context) {
  return Column(
    children: [
      Container(
        width: 71.w,
        height: 71.w,
        decoration: BoxDecoration(
          color: AppColors.forestGreen.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          'assets/icon/compass.svg',
          width: 42.w,
          height: 42.w,
          colorFilter: ColorFilter.mode(AppColors.forestGreen, BlendMode.srcIn),
        ),
      ),
      SizedBox(height: 10.h),
      Text(
        AppLocalizations.of(context)!.hiddenSpot,
        style: TextStyle(
          color: AppColors.forestGreen,
          fontSize: 30.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
      SizedBox(height: 10.h),
      Text(
        AppLocalizations.of(context)!.heroDescription,
        style: TextStyle(
          color: Color(0xFF6B8065),
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

//MARK: 현재 위치 저장하기 저장된 장소
Widget _statCard(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 26.w),
    child: Container(
      constraints: BoxConstraints(minHeight: 85.h), // Figma 높이
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFDBE5DB)),
      ),
      child: Column(
        children: [
          SizedBox(height: 15.h),
          Text(
            AppLocalizations.of(context)!.savedLocation,
            style: TextStyle(
              color: Color(0xFF6B8065),
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Consumer<StoreLocationViewmodel>(
            builder: (context, vm, _) {
              return Text(
                // "${vm.spots.length}개",
                AppLocalizations.of(context)!.spotCount(vm.spots.length),
                style: TextStyle(
                  color: AppColors.forestGreen,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

//MARK: 현재 위치 저장하기
Widget _saveCurrentLocation(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 26.w),
    child: Material(
      color: Colors.transparent, // 잊지 마! 배경색은 Container에서 처리함
      child: InkWell(
        borderRadius: BorderRadius.circular(15), // ripple도 radius 맞춰야 자연스러움
        onTap: () {
          HapticFeedback.mediumImpact();
          showDialog(
            context: context,
            barrierDismissible: false, // 외부 터치로 닫히지 않게 함
            builder: (_) => SaveCurrentLocationView(),
          );
        },
        child: Container(
          constraints: BoxConstraints(minHeight: 63.h),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icon/currentSpot.svg',
                  width: 24.w,
                  height: 24.w,
                ),
                SizedBox(width: 15.w),
                Text(
                  AppLocalizations.of(context)!.saveCurrentLocation,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

//MARK: 저장된 장소 보기
Widget _viewSavedLocations(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 26.w),
    child: Material(
      color: Colors.transparent, // 잊지 마! 배경색은 Container에서 처리함
      child: InkWell(
        borderRadius: BorderRadius.circular(15), // ripple도 radius 맞춰야 자연스러움
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SavedLocationsView()),
          );
          HapticFeedback.mediumImpact();
        },
        child: Container(
          constraints: BoxConstraints(minHeight: 63.h), // Figma 높이
          decoration: BoxDecoration(
            color: Color(0xFFF8FDF6),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.forestGreen),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.25,
                ), // #000000, opacity 25%
                offset: Offset(0, 2), // X:0, Y:2
                blurRadius: 4, // 흐림(Blur): 4
                spreadRadius: 0, // 스프레드: 0
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icon/storeSpot.svg',
                  width: 24.w,
                  height: 24.w,
                ),
                SizedBox(width: 15.w),
                Text(
                  AppLocalizations.of(context)!.viewSavedLocation,
                  style: TextStyle(
                    color: AppColors.forestGreen,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

//MARK: 사용 팁
Widget _tipsCard(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 26.w),
    child: Container(
      constraints: BoxConstraints(minHeight: 130.h), // Figma 높이
      padding: EdgeInsets.only(left: 10.w, top: 10.h),
      decoration: BoxDecoration(
        color: Color(0xFFD6F1D6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.tipsTitle,
            style: TextStyle(
              color: AppColors.forestGreen,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            '${AppLocalizations.of(context)!.mainGuide1}\n'
            '${AppLocalizations.of(context)!.mainGuide2}\n'
            '${AppLocalizations.of(context)!.mainGuide3}\n',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              height: 1.6,
              color: const Color(0xFF6F8469),
            ),
          ),
        ],
      ),
    ),
  );
}
