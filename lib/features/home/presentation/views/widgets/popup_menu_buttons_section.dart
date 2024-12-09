import 'package:flutter/material.dart';
import 'package:tasky/config/routes/app_routes.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/features/home/data/models/task_model/task_model.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_cubit.dart';

class PopupMenuButtonsSection extends StatelessWidget {
  const PopupMenuButtonsSection({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radius8r)
      ),
      iconSize: MediaQuery.sizeOf(context).width > 780
          ? AppConstants.iconSize20
          : AppConstants.iconSize24,
      onSelected: (value) {

        if (value ==  AppStrings.edit) {
          Navigator.pushNamed(context, Routes.updateTaskView,arguments: taskModel);
        } else if (value ==  AppStrings.delete) {
          TaskOperationsCubit.get(context).deleteTask(taskId: taskModel.id);
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: AppStrings.edit,
            child: Text(
              AppStrings.edit,
              style: AppStyles.styleMedium16Black,
            ),
          ),
          PopupMenuItem<String>(
            value: AppStrings.delete,
            child: Text(
              AppStrings.delete,
              style: AppStyles.styleMedium16Black.copyWith(
                color: AppColors.redAccent,
              ),
            ),
          ),
        ];
      },
    );
  }
}
