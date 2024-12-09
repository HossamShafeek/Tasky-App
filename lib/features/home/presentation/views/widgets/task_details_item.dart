import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';

class TaskDetailsItem extends StatelessWidget {
  const TaskDetailsItem({super.key, required this.icon, required this.content});

  final Widget icon;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstants.size8h),
      margin: EdgeInsets.only(bottom: AppConstants.size8h),
      width: double.infinity,
      height: AppConstants.size45h,
      decoration: BoxDecoration(
        color: AppColors.primaryWithOpacity,
        borderRadius: BorderRadius.circular(AppConstants.radius10r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          content,
          icon,
        ],
      ),
    );
  }
}
