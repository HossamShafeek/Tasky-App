import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:tasky/core/animations/fade_transition_animation.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_text_button.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_state.dart';

class AddTaskImage extends StatelessWidget {
  const AddTaskImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskOperationsCubit, TaskOperationsState>(
      builder: (contextForBloc, state) {
        return FadeTransitionAnimation(
          duration: const Duration(milliseconds: 600),
          child: GestureDetector(
            onTap: () {
              showAdaptiveDialog(
                context: contextForBloc,
                builder: (context) {
                  return AlertDialog.adaptive(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.radius8r)
                    ),
                    title: Text(
                      AppStrings.chooseImageFrom,
                      style: AppStyles.styleRegular18White.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    actions: [
                      CustomTextButton(
                        onPressed: () {
                          TaskOperationsCubit.get(contextForBloc)
                              .getImageFromCamera();
                          Navigator.pop(context);
                        },
                        title: AppStrings.camera,
                      ),
                      CustomTextButton(
                        onPressed: () {
                          TaskOperationsCubit.get(contextForBloc)
                              .getImageFromGallery();
                          Navigator.pop(context);
                        },
                        title: AppStrings.gallery,
                      ),
                    ],
                  );
                },
              );
            },
            child: DottedBorder(
              color: AppColors.primary,
              strokeWidth: 1.h,
              borderPadding: const EdgeInsets.all(1),
              radius: Radius.circular(AppConstants.radius10r),
              dashPattern: const [2, 2],
              // Dash length and gap
              borderType: BorderType.RRect,
              child: Container(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                height: AppConstants.size45h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radius10r),
                ),
                child: TaskOperationsCubit.get(context).image == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.addImage,
                            height: MediaQuery.sizeOf(context).width > 780
                                ? AppConstants.iconSize20
                                : AppConstants.iconSize22,
                            width: MediaQuery.sizeOf(context).width > 780
                                ? AppConstants.iconSize20
                                : AppConstants.iconSize22,
                          ),
                          Gap(AppConstants.size5w),
                          Text(
                            AppStrings.addImage,
                            style: AppStyles.styleMedium19Primary,
                          ),
                        ],
                      )
                    : Image.file(
                        TaskOperationsCubit.get(context).image!,
                        fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
