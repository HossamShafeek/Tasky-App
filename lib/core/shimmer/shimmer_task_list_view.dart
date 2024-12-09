import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tasky/core/shimmer/shimmer_container_effect.dart';
import 'package:tasky/core/shimmer/shimmer_task_list_view_item.dart';
import 'package:tasky/core/utils/app_constants.dart';

class ShimmerTaskListView extends StatelessWidget {
  const ShimmerTaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(vertical: AppConstants.size10h),
            child: Row(
              children: [
                 Expanded(
                  flex: 1,
                  child: ShimmerContainerEffect(
                    height: AppConstants.size30h,
                    borderRadius: AppConstants.radius24r,
                  ),
                ),
                Gap(AppConstants.size10w),
                 Expanded(
                  flex: 3,
                  child: ShimmerContainerEffect(
                    height: AppConstants.size30h,
                    borderRadius: AppConstants.radius24r,
                  ),
                ),
                Gap(AppConstants.size10w),
                 Expanded(
                  flex: 2,
                  child: ShimmerContainerEffect(
                    height: AppConstants.size30h,
                    borderRadius: AppConstants.radius24r,
                  ),
                ),
                Gap(AppConstants.size10w),
                 Expanded(
                  flex: 2,
                  child: ShimmerContainerEffect(
                    height: AppConstants.size30h,
                    borderRadius: AppConstants.radius24r,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const ShimmerTaskListViewItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}

