import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_cubit.dart';

class TaskTextsFields extends StatelessWidget {
  const TaskTextsFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: AppConstants.size15h,
            bottom: AppConstants.size8h,
          ),
          child: Text(
            AppStrings.taskTitle,
            style: AppStyles.styleRegular12Grey600,
          ),
        ),
        CustomTextField(
          textInputType: TextInputType.text,
          controller: TaskOperationsCubit.get(context).titleController,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return AppStrings.pleaseEnterTaskTitle;
            }
            return null;
          },
          hintText: AppStrings.enterTitleHere,
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: AppConstants.size8h,
          ),
          child: Text(
            AppStrings.taskDescription,
            style: AppStyles.styleRegular12Grey600,
          ),
        ),
        CustomTextField(
          textInputType: TextInputType.text,
          maxLines: 8,
          controller: TaskOperationsCubit.get(context).descriptionController,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return AppStrings.pleaseEnterDescription;
            }
            return null;
          },
          hintText: AppStrings.enterDescriptionHere,
        ),
      ],
    );
  }
}