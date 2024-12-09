import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/core/animations/fade_transition_animation.dart';
import 'package:tasky/core/api/end_points.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_network_image.dart';
import 'package:tasky/core/widgets/custom_text_button.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_state.dart';

class UpdateTaskImage extends StatelessWidget {
  const UpdateTaskImage({super.key, required this.imageFromModel});

  final String imageFromModel;

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
                height: MediaQuery
                    .sizeOf(context)
                    .height / 3.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radius10r),
                ),
                child: TaskOperationsCubit
                    .get(context)
                    .image == null
                    ? CustomNetworkImage(image: '${EndPoints.baseUrl}${EndPoints
                    .viewImages}$imageFromModel',)
                    : Image.file(
                  TaskOperationsCubit
                      .get(context)
                      .image!,
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