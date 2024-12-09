import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tasky/core/utils/app_colors.dart';

class ShimmerCircleAvatarEffect extends StatelessWidget {
  const ShimmerCircleAvatarEffect({super.key,  this.radius});

  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.withOpacity(0.3),
      highlightColor: AppColors.white.withOpacity(0.6),
      child: CircleAvatar(
        backgroundColor: AppColors.white.withOpacity(0.9),
        radius: radius ??6.r,
      ),
    );
  }
}
