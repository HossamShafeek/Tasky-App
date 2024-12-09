import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/features/home/data/models/task_model/task_model.dart';
import 'package:tasky/features/home/presentation/views/widgets/task_details_item.dart';

class TaskDetailsSection extends StatelessWidget {
  const TaskDetailsSection({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppConstants.defaultPadding,
        left: AppConstants.defaultPadding,
        right: AppConstants.defaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            taskModel.title,
            style: AppStyles.styleBold24Black,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppConstants.size8h),
            child: Text(
              taskModel.description,
              style: AppStyles.styleRegular14Grey,
            ),
          ),
          TaskDetailsItem(
            icon: SvgPicture.asset(
              AppAssets.calendar,
              height: MediaQuery.sizeOf(context).width > 780
                  ? AppConstants.iconSize20
                  : AppConstants.iconSize24,
              width: MediaQuery.sizeOf(context).width > 780
                  ? AppConstants.iconSize20
                  : AppConstants.iconSize24,
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.endDate,
                  style: AppStyles.styleRegular12Grey600,
                ),
                Text(
                  DateFormat.yMd().format(
                      DateTime.parse(taskModel.createdAt)),
                  style: AppStyles.styleRegular16Black,
                ),
              ],
            ),
          ),
          TaskDetailsItem(
            icon: SvgPicture.asset(
              AppAssets.arrowDown,
              height: MediaQuery.sizeOf(context).width > 780
                  ? AppConstants.iconSize20
                  : AppConstants.iconSize24,
              width: MediaQuery.sizeOf(context).width > 780
                  ? AppConstants.iconSize20
                  : AppConstants.iconSize24,
            ),
            content: Text(
              taskModel.status,
              style: AppStyles.styleBold16Black.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          TaskDetailsItem(
            icon: SvgPicture.asset(
              AppAssets.arrowDown,
              height: MediaQuery.sizeOf(context).width > 780
                  ? AppConstants.iconSize20
                  : AppConstants.iconSize24,
              width: MediaQuery.sizeOf(context).width > 780
                  ? AppConstants.iconSize20
                  : AppConstants.iconSize24,
            ),
            content: Row(
              children: [
                SvgPicture.asset(
                  AppAssets.flag,
                  height: MediaQuery.sizeOf(context).width > 780
                      ? AppConstants.iconSize16
                      : AppConstants.iconSize18,
                  width: MediaQuery.sizeOf(context).width > 780
                      ? AppConstants.iconSize16
                      : AppConstants.iconSize18,
                ),
                Gap(AppConstants.size5w),
                Text(
                  '${taskModel.priority} priority',
                  style: AppStyles.styleBold16Black.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
