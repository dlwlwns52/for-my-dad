import 'package:flutter/material.dart';
import 'package:fms/save_location/save_currentlocation_viewmodel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms/constants/app_colors.dart';
import 'package:flutter/services.dart'; // 햅틱용
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';

class SaveCurrentLocationView extends StatefulWidget {
  const SaveCurrentLocationView({super.key});

  @override
  State<SaveCurrentLocationView> createState() => _SaveCurrentLocationState();
}

class _SaveCurrentLocationState extends State<SaveCurrentLocationView> {
  final placeNameController = TextEditingController();
  final memoController = TextEditingController();

  @override
  void dispose() {
    placeNameController.dispose();
    memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SaveCurrentLocationViewModel(),
      builder: (context, _) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 11.w),
          backgroundColor: const Color(0xFFF8FDF6),

          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 373.w, maxHeight: 615.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDialogHeader(context),
                    SizedBox(height: 25.h),
                    _buildPlaceNameField(context, placeNameController),
                    SizedBox(height: 16.h),
                    _buildMemoField(context, memoController),
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
      },
    );
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
  Widget _buildPlaceNameField(
    BuildContext context,
    TextEditingController placeNameController,
  ) {
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
            controller: placeNameController,
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

  //MARK:메모 (선택사항)
  Widget _buildMemoField(
    BuildContext context,
    TextEditingController memoController,
  ) {
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
            controller: memoController,
            maxLength: 100,
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
              counterText: "",
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
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: memoController,
            builder: (context, value, _) {
              return Text(
                "${value.text.length}/100자",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF6B8166),
                  fontFamily: "Pretendard",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  //MARK: 사진 (선택사항)
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
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              showImageSourceBottomSheet(context);
            },
            child: Consumer<SaveCurrentLocationViewModel>(
              builder: (context, vm, _) {
                if (vm.selectedImage != null) {
                  return Image.file(
                    vm.selectedImage!,
                    width: double.infinity,
                    height: 130.h,
                  );
                } else if (vm.selectedImages.isNotEmpty) {
                  return SizedBox(
                    height: 100.h,
                    width: double.infinity,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: vm.selectedImages.length,
                      itemBuilder: (context, index) {
                        return Image.file(
                          vm.selectedImages[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  );
                } else {
                  return DottedBorder(
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
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void showImageSourceBottomSheet(BuildContext context) {
    final primaryColor = const Color(0xFF183317); // 앱 메인 컬러
    final viewModel = context.read<SaveCurrentLocationViewModel>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFFF7FDF5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(33.w, 24.h, 33.w, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '사진 추가',
                  style: TextStyle(
                    color: Color(0xFB183317),
                    fontFamily: "Pretendard",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 27.h),

                // 사진 촬영
                SizedBox(
                  width: double.infinity,
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      HapticFeedback.mediumImpact();
                      Navigator.pop(context);
                      await viewModel.pickCamera();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF275025),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icon/camera.svg',
                          width: 24.w,
                          height: 24.w,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          '사진 촬영',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: "Pretendard",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 27.h),

                // 앨범에서 선택
                SizedBox(
                  width: double.infinity,
                  height: 60.h,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      HapticFeedback.mediumImpact();
                      Navigator.pop(context);
                      await viewModel.pickImages();
                      return;
                    },
                    icon: Icon(
                      Icons.photo_library,
                      color: primaryColor,
                      size: 24,
                    ),
                    label: Text(
                      '앨범에서 선택',
                      style: TextStyle(
                        color: Color(0xFB183317),
                        fontFamily: "Pretendard",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primaryColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 27.h),
                // 취소 버튼
                TextButton(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    Navigator.pop(context);
                  },
                  child: Text(
                    '취소',
                    style: TextStyle(
                      color: Color(0xFF647A60),
                      fontFamily: "Pretendard",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //MARK: 저장, 취소
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
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
