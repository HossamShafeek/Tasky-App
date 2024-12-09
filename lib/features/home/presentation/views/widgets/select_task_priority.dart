import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_dropdown.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_cubit.dart';

class SelectTaskPriority extends StatelessWidget {
  const SelectTaskPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: AppConstants.size8h,
          ),
          child: Text(
            AppStrings.priority,
            style: AppStyles.styleRegular12Grey600,
          ),
        ),
        CustomDropdown(
          value:  TaskOperationsCubit.get(context).priority,
          hintText: AppStrings.choosePriority,
          messageForValidate: AppStrings.pleaseChoosePriority,
          items: ['low', 'medium', 'high']
              .map(
                (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
              .toList(),
          onChange: (value) {
            TaskOperationsCubit.get(context).priority = value;
          },
        ),
      ],
    );
  }
}