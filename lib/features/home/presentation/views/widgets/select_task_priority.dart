import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/core/utils/app_colors.dart';
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
          backgroundColor: AppColors.primaryWithOpacity,
          value: TaskOperationsCubit.get(context).priority,
          hintText: AppStrings.choosePriority,
          messageForValidate: AppStrings.pleaseChoosePriority,
          border: AppConstants.removeBorder,
          focusedBorder: AppConstants.removeBorder,
          icon: SvgPicture.asset(
            AppAssets.arrowDown,
            height: MediaQuery.sizeOf(context).width > 780
                ? AppConstants.iconSize20
                : AppConstants.iconSize24,
            width: MediaQuery.sizeOf(context).width > 780
                ? AppConstants.iconSize20
                : AppConstants.iconSize24,
          ),
          items: ['low', 'medium', 'high']
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Row(
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
                      Gap(AppConstants.size3w),
                      Text(
                        '${e[0].toUpperCase() + e.replaceRange(0, 1, '')} Priority',
                        style: AppStyles.styleBold16Black.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
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
