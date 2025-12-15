import 'package:flutter/material.dart';
import 'package:fms/Module/db/hive_Service.dart';
import 'package:fms/Module/utils/snack_bar.dart';
import 'package:fms/StoreLocationViewmodel.dart';
import 'package:fms/save_location/save_currentlocation_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms/constants/app_colors.dart';
import 'package:flutter/services.dart'; // 햅틱용
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';
import 'package:fms/l10n/app_localizations.dart';

class SaveCurrentLocationView extends StatefulWidget {
  const SaveCurrentLocationView({super.key});

  @override
  State<SaveCurrentLocationView> createState() => _SaveCurrentLocationState();
}

class _SaveCurrentLocationState extends State<SaveCurrentLocationView> {
  final placeNameController = TextEditingController();
  final memoController = TextEditingController();
  final FocusNode _placeNameFocusNode = FocusNode();
  final FocusNode _memoFocusNode = FocusNode();

  @override
  void dispose() {
    placeNameController.dispose();
    memoController.dispose();
    _placeNameFocusNode.dispose();
    _memoFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SaveCurrentLocationViewModel(SpotService()),
      builder: (context, _) {
        return Builder(
          builder: (context) => Scaffold(
            backgroundColor: Colors.transparent, // 투명하게 유지
            body: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              insetPadding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 11.w,
              ),
              backgroundColor: const Color(0xFFF8FDF6),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).unfocus(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 373.w,
                    maxHeight: 615.h,
                  ),
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
                  AppLocalizations.of(context)!.saveCurrentLocationTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.forestGreen,
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
                  text: AppLocalizations.of(context)!.saveCurrentLocationDesc1,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: AppLocalizations.of(context)!.saveCurrentLocationDesc2,
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
            AppLocalizations.of(context)!.placeNameLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.midiumText,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            maxLength: 10,
            controller: placeNameController,
            focusNode: _placeNameFocusNode,
            textInputAction: TextInputAction.next,
            // 입력하는 텍스트 스타일
            style: TextStyle(
              color: AppColors.midiumText,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
            cursorColor: AppColors.midiumText,
            cursorHeight: 20.0.h,
            decoration: InputDecoration(
              counterText: "",
              hintText: AppLocalizations.of(context)!.placeNameHint,
              hintStyle: TextStyle(
                color: AppColors.forestGreen,
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
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(_memoFocusNode);
            },
          ),
          SizedBox(height: 8.h),
          ValueListenableBuilder(
            valueListenable: placeNameController,
            builder: (context, value, _) {
              return Text(
                AppLocalizations.of(
                  context,
                )!.characterCount(value.text.length, 10),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF6B8166),
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
            AppLocalizations.of(context)!.memoLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.midiumText,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: memoController,
            focusNode: _memoFocusNode,
            textInputAction: TextInputAction.done,
            maxLength: 100,
            maxLines: 2,
            // 입력하는 텍스트 스타일
            style: TextStyle(
              color: AppColors.midiumText,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
            cursorColor: AppColors.midiumText,
            cursorHeight: 20.0.h,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.memoHint,
              counterText: "",
              hintStyle: TextStyle(
                color: AppColors.forestGreen,
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
          ValueListenableBuilder(
            valueListenable: memoController,
            builder: (context, value, _) {
              return Text(
                AppLocalizations.of(
                  context,
                )!.characterCount(value.text.length, 100),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF6B8166),
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
            AppLocalizations.of(context)!.photoLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.midiumText,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Consumer<SaveCurrentLocationViewModel>(
            builder: (context, vm, _) {
              if (vm.selectedImages.isNotEmpty) {
                return Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true, // 내용 높이에 맞게 자동 확장
                      physics: const NeverScrollableScrollPhysics(), // 스크롤 막기
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 한 줄에 2장씩
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: vm.selectedImages.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: Image.file(
                                vm.selectedImages[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),

                            // 삭제 버튼 (우측 상단 X)
                            Positioned(
                              right: 4,
                              top: 4,
                              child: GestureDetector(
                                onTap: () {
                                  HapticFeedback.mediumImpact();
                                  vm.removeImageAt(index);
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    color: Color(0xFFD4183D),
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        showImageSourceBottomSheet(context);
                      },
                      child: DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          color: Color(0xFFD6E2D4),
                          radius: Radius.circular(12),
                          dashPattern: [6, 5], //실선 길이, 공백 길이
                          strokeWidth: 3,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 100.h, // 필요 시 고정 높이
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
                                AppLocalizations.of(context)!.addPhotoHint,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color(0xFF6B8166),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    showImageSourceBottomSheet(context);
                  },
                  child: DottedBorder(
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
                            AppLocalizations.of(context)!.addPhotoHint,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xFF6B8166),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  //MARK: 사진 촬영' 및 '앨범에서 선택' 옵션을 제공하는 바텀시트
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
                  AppLocalizations.of(context)!.addPhotoTitle,
                  style: TextStyle(
                    color: Color(0xFB183317),
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
                          AppLocalizations.of(context)!.takePhoto,
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
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
                      AppLocalizations.of(context)!.pickFromGallery,
                      style: TextStyle(
                        color: Color(0xFB183317),
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
                    AppLocalizations.of(context)!.cancel,
                    style: TextStyle(
                      color: Color(0xFF647A60),
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
          //MARK: 저장
          Consumer<SaveCurrentLocationViewModel>(
            builder: (context, vm, _) {
              return ValueListenableBuilder(
                valueListenable: placeNameController,
                builder: (BuildContext context, dynamic value, _) {
                  final isEmpty = value.text.trim().isEmpty;
                  final isDisabled = isEmpty || vm.isSaving;
                  return InkWell(
                    onTap: isDisabled
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            HapticFeedback.mediumImpact();
                            try {
                              await vm.saveCurrentSpot(
                                placeName: placeNameController.text,
                                memo: memoController.text,
                              );
                              if (!context.mounted) return;
                              await context
                                  .read<StoreLocationViewmodel>()
                                  .loadSpots();

                              placeNameController.clear();
                              memoController.clear();
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(
                                  AppLocalizations.of(
                                    context,
                                  )!.locationSavedSnapshot,
                                ),
                              );
                              Navigator.pop(context);
                            } catch (e) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(customSnackBar(e.toString()));
                            }
                          },
                    child: Container(
                      width: double.infinity,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: isDisabled ? Colors.grey : AppColors.forestGreen,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: vm.isSaving
                            ? SizedBox(
                                width: 18.w,
                                height: 18.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                AppLocalizations.of(context)!.save,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(height: 15.h),
          //MARK: 취소
          ValueListenableBuilder(
            valueListenable: placeNameController,
            builder: (BuildContext context, dynamic value, _) {
              final isEmpty = value.text.trim().isEmpty;
              bool isCancelClicked = false;
              return InkWell(
                onTap: () {
                  if (context.read<SaveCurrentLocationViewModel>().isSaving) {
                    return;
                  }
                  if (!isEmpty) {
                    if (isCancelClicked) {
                      HapticFeedback.mediumImpact();
                      Navigator.pop(context);
                    }
                    HapticFeedback.mediumImpact();
                    ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(
                        AppLocalizations.of(context)!.cancelConfirmSnapshot,
                      ),
                    );
                    isCancelClicked = true;
                  } else {
                    HapticFeedback.mediumImpact();
                    Navigator.pop(context);
                  }
                },
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
                      AppLocalizations.of(context)!.cancel,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
