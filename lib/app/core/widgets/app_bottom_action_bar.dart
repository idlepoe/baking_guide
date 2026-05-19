import 'package:flutter/material.dart';

/// 화면·바텀시트 하단 고정 액션 영역 패딩 래퍼.
class AppBottomActionBar extends StatelessWidget {
  const AppBottomActionBar({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(16, 12, 16, 16),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}
