import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/core/shimmer/shimmer_container_effect.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';

class ShimmerProfileItem extends StatelessWidget {
  const ShimmerProfileItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstants.size10h),
      margin: EdgeInsets.only(bottom: AppConstants.size15h),
      width: double.infinity,
      height: 65.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.radius10r),
        color: AppColors.grey200,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: ShimmerContainerEffect(),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ShimmerContainerEffect(),
              ),
              Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
