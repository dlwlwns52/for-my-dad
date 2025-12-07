import 'package:flutter/material.dart';

class SwipeBackDetector extends StatelessWidget {
  final Widget child;
  const SwipeBackDetector({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 수평 드래그 감지
      onHorizontalDragEnd: (details) {
        // 오른쪽으로 빠르게 스와이프 (Left -> Right)
        // 안드로이드/iOS 기본 뒤로가기 제스처와 방향 일치
        if (details.primaryVelocity! > 500) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
      },
      child: child,
    );
  }
}
