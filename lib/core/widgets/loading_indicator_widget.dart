import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final double strokeWidth;
  final Color color;

  const LoadingIndicatorWidget({
    super.key,
    this.strokeWidth = 4.0,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
