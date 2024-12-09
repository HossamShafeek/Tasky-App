import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tasky/core/shimmer/shimmer_container_effect.dart';
import 'package:tasky/core/utils/app_constants.dart';

class ShimmerTaskListViewItem extends StatelessWidget {
  const ShimmerTaskListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppConstants.size10h,
      ),
      height: 90.h,
      width: double.infinity,
      child: Row(
        children: [
          const AspectRatio(
              aspectRatio: 1, child: ShimmerContainerEffect()),
          Gap(AppConstants.size10w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Expanded(
                        flex: 3, child: ShimmerContainerEffect()),
                    Gap(AppConstants.size10w),
                    const Expanded(child: ShimmerContainerEffect()),
                  ],
                ),
                const ShimmerContainerEffect(),
                const Row(
                  children: [
                    Expanded(child: ShimmerContainerEffect()),
                    Expanded(child: SizedBox()),
                    Expanded(child: ShimmerContainerEffect()),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
