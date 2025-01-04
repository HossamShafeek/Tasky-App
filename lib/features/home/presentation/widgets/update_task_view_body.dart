import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tasky/config/routes/app_routes.dart';
import 'package:tasky/core/functions/show_snack_bar.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/widgets/custom_elevated_button.dart';
import 'package:tasky/features/home/domain/entities/task_entity.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_state.dart';
import 'package:tasky/features/home/presentation/widgets/select_task_priority.dart';
import 'package:tasky/features/home/presentation/widgets/select_task_status.dart';
import 'package:tasky/features/home/presentation/widgets/task_texts_fields.dart';
import 'package:tasky/features/home/presentation/widgets/update_task_image.dart';

class UpdateTaskViewBody extends StatelessWidget {
  const UpdateTaskViewBody({super.key, required this.taskEntity});

  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskOperationsCubit, TaskOperationsState>(
      listener: (context, state) {
        if (state is UploadImageSuccessState) {
          TaskOperationsCubit.get(context).updateTask(
            taskId: taskEntity.id,
            imageFromModel: taskEntity.image!,
          );
        } else if (state is UploadImageFailureState) {
          showErrorSnackBar(context: context, message: state.error);
        } else if (state is UpdateTaskSuccessState) {
          showSuccessSnackBar(context: context, message: state.message);
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.homeView,
            (route) => false,
          );
        } else if (state is UpdateTaskFailureState) {
          showErrorSnackBar(context: context, message: state.error);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: AppConstants.defaultPadding,
          right: AppConstants.defaultPadding,
          left: AppConstants.defaultPadding,
        ),
        child: Form(
          key: TaskOperationsCubit.get(context).formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UpdateTaskImage(
                  imageFromModel: taskEntity.image!,
                ),
                const TaskTextsFields(),
                const SelectTaskPriority(),
                const SelectTaskStatus(),
                CustomElevatedButton(
                  onPressed: () async {
                    if (TaskOperationsCubit.get(context)
                        .formKey
                        .currentState!
                        .validate()) {
                      if (TaskOperationsCubit.get(context).image != null) {
                        TaskOperationsCubit.get(context).uploadImage();
                      } else {
                        TaskOperationsCubit.get(context).updateTask(
                          taskId: taskEntity.id,
                          imageFromModel: taskEntity.image!,
                        );
                      }
                    }
                  },
                  title: AppStrings.editTask,
                ),
                Gap(AppConstants.defaultPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
