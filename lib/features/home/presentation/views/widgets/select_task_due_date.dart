import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_state.dart';

class SelectTaskDueDate extends StatelessWidget {
  const SelectTaskDueDate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskOperationsCubit, TaskOperationsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: AppConstants.size8h,
              ),
              child: Text(
                AppStrings.dueDate,
                style: AppStyles.styleRegular12Grey600,
              ),
            ),
            CustomTextField(
              controller: TaskOperationsCubit.get(context).dueDateController,
              hintText:  AppStrings.chooseDueDate,
              readOnly: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppStrings.pleaseChooseDueDate;
                }
                return null;
              },
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 5),
                ).then(
                  (value) {
                    if (value != null) {
                      TaskOperationsCubit.get(context).selectDueDate(
                        dueDate: DateFormat.yMd().format(value),
                      );
                    }
                  },
                );
              },
              suffixIcon: SizedBox(

                height: MediaQuery.sizeOf(context).width > 780
                    ? AppConstants.iconSize20
                    : AppConstants.iconSize24,
                width: MediaQuery.sizeOf(context).width > 780
                    ? AppConstants.iconSize20
                    : AppConstants.iconSize24,
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.calendar,
                    height: MediaQuery.sizeOf(context).width > 780
                        ? AppConstants.iconSize20
                        : AppConstants.iconSize24,
                    width: MediaQuery.sizeOf(context).width > 780
                        ? AppConstants.iconSize20
                        : AppConstants.iconSize24,
                  ),
                ),
              ),

            ),
          ],
        );
      },
    );
  }
}
