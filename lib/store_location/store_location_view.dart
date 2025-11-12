import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms/Module/db/hive_Service.dart';
import 'package:fms/constants/app_colors.dart';
import 'package:fms/store_location/store_location_viewmodel.dart';
import 'package:provider/provider.dart';

class SavedPlacesView extends StatelessWidget {
  const SavedPlacesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreLocationViewmodel(SpotService())..init(),
      builder: (context, _) {
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
                  child: CircularProgressIndicator(),
                ); //로딩중일때 TODO: 추후에 디자인 적용
              }
              if (vm.error != null) {
                //에러발생시 TODO: 추후에 디자인 적용
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '불러오기 실패\n${vm.error}',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: vm.loadSpots,
                          child: const Text('다시 시도'),
                        ),
                      ],
                    ),
                  ),
                );
              }
              // if (vm.spots.isEmpty) {
              return RefreshIndicator(
                onRefresh: vm.loadSpots,
                child: ListView(
                  children: const [
                    SizedBox(height: 160),
                    Center(child: Text('저장된 장소가 없습니다.')),
                  ],
                ),
              );
              // }
              // return Padding(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 16,
              //     vertical: 18,
              //   ),
              // );
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



          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          //   child: ListView.builder(
          //     itemCount: places.length,
          //     itemBuilder: (context, index) {
          //       final place = places[index];
          //       return Container(
          //         margin: const EdgeInsets.only(bottom: 16),
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(16),
          //           border: Border.all(color: const Color(0xFFDBE5DB)),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.black.withValues(alpha: 0.05),
          //               blurRadius: 4,
          //               offset: const Offset(0, 2),
          //             ),
          //           ],
          //         ),
          //         child: Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               // 제목과 버튼들
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(
          //                     place['title']!,
          //                     style: const TextStyle(
          //                       fontSize: 18,
          //                       fontWeight: FontWeight.w700,
          //                       color: Color(0xFF183317),
          //                     ),
          //                   ),
          //                   Row(
          //                     children: [
          //                       _iconButton(
          //                         icon: Icons.map,
          //                         borderColor: const Color(0xFF2468E2),
          //                         iconColor: const Color(0xFF2468E2),
          //                         onPressed: () {},
          //                       ),
          //                       const SizedBox(width: 8),
          //                       _iconButton(
          //                         icon: Icons.navigation_outlined,
          //                         borderColor: const Color(0xFF275025),
          //                         iconColor: const Color(0xFF275025),
          //                         onPressed: () {},
          //                       ),
          //                       const SizedBox(width: 8),
          //                       _iconButton(
          //                         icon: Icons.delete_outline,
          //                         borderColor: const Color(0xFFD73B3B),
          //                         iconColor: const Color(0xFFD73B3B),
          //                         onPressed: () {},
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //               const SizedBox(height: 12),
          //               Text.rich(
          //                 TextSpan(
          //                   text: '거리: ',
          //                   style: TextStyle(
          //                     color: Color(0xFF647A60),
          //                     fontWeight: FontWeight.w500,
          //                     fontSize: 14.sp,
          //                   ),
          //                   children: [
          //                     TextSpan(
          //                       text: place['distance'],
          //                       style: const TextStyle(
          //                         fontWeight: FontWeight.w700,
          //                         color: Color(0xFF183317),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               const SizedBox(height: 4),
          //               Text.rich(
          //                 TextSpan(
          //                   text: '저장: ',
          //                   style: TextStyle(
          //                     color: Color(0xFF647A60),
          //                     fontWeight: FontWeight.w500,
          //                     fontSize: 14.sp,
          //                   ),
          //                   children: [
          //                     TextSpan(
          //                       text: place['date'],
          //                       style: const TextStyle(
          //                         color: Color(0xFF183317),
          //                         fontWeight: FontWeight.w700,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),

          //               //사진
          //               // memo
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),