import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tasky/config/routes/app_routes.dart';
import 'package:tasky/core/functions/show_snack_bar.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/widgets/custom_elevated_button.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_state.dart';
import 'package:tasky/features/home/presentation/views/widgets/select_task_due_date.dart';
import 'package:tasky/features/home/presentation/views/widgets/add_task_image.dart';
import 'package:tasky/features/home/presentation/views/widgets/select_task_priority.dart';
import 'package:tasky/features/home/presentation/views/widgets/task_texts_fields.dart';

class AddTaskViewBody extends StatelessWidget {
  const AddTaskViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskOperationsCubit, TaskOperationsState>(
      listener: (context, state) {
        if(state is UploadImageSuccessState){
          TaskOperationsCubit.get(context).addTask();
        }else if (state is UploadImageFailureState) {
          showErrorSnackBar(context: context, message: state.error);
        }else if (state is AddTaskSuccessState) {
          showSuccessSnackBar(context: context, message: state.message);
          Navigator.pushNamedAndRemoveUntil(context, Routes.homeView,(route) => false,);
        } else if (state is AddTaskFailureState) {
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
                const AddTaskImage(),
                const TaskTextsFields(),
                const SelectTaskPriority(),
                const SelectTaskDueDate(),
                CustomElevatedButton(
                  onPressed: () async{
                    if (TaskOperationsCubit.get(context)
                        .formKey
                        .currentState!
                        .validate()) {
                      if(TaskOperationsCubit.get(context).image!=null){
                        TaskOperationsCubit.get(context).uploadImage();

                      }else{
                        showErrorSnackBar(context: context, message: 'Please select image');
                      }
                    }
                  },
                  title: AppStrings.addTask,
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
