import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tasky/config/routes/app_routes.dart';
import 'package:tasky/core/api/end_points.dart';
import 'package:tasky/core/functions/get_task_color.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_network_image.dart';
import 'package:tasky/features/home/domain/entities/task_entity.dart';

class TaskListViewItem extends StatelessWidget {
  const TaskListViewItem({super.key, required this.taskEntity});

  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.taskDetailsView,
            arguments: taskEntity);
      },
      child: Container(
        height: 90.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: AppConstants.size10h,
        ),
          color: AppColors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CustomNetworkImage(
                image:
                    '${EndPoints.baseUrl}${EndPoints.viewImages}${taskEntity.image!}',
              ),
            ),
            Gap(AppConstants.size10w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          taskEntity.title,
                          style: AppStyles.styleBold16Black,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Gap(AppConstants.size3w),
                      Container(
                        padding: EdgeInsets.all(AppConstants.size5h),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppConstants.radius5r),
                          color: getStatusBackgroundColor(
                              status: taskEntity.status),
                        ),
                        child: Text(
                          taskEntity.status,
                          style: AppStyles.styleMedium12Black.copyWith(
                            color: getStatusColor(status: taskEntity.status),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    taskEntity.description,
                    style: AppStyles.styleRegular14Grey,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.flag,
                            height: MediaQuery.sizeOf(context).width > 780
                                ? AppConstants.iconSize14
                                : AppConstants.iconSize16,
                            width: MediaQuery.sizeOf(context).width > 780
                                ? AppConstants.iconSize14
                                : AppConstants.iconSize16,
                            colorFilter: ColorFilter.mode(
                              getStatusPriorityColor(
                                  status: taskEntity.priority),
                              // Use the state color for tinting
                              BlendMode.srcIn,
                            ),
                          ),
                          Gap(AppConstants.size3w),
                          Text(
                            taskEntity.priority,
                            style: AppStyles.styleMedium12Black.copyWith(
                              color: getStatusPriorityColor(
                                  status: taskEntity.priority),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateFormat.yMd()
                            .format(DateTime.parse(taskEntity.createdAt)),
                        style: AppStyles.styleRegular14Grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
