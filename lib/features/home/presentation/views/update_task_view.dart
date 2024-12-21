import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/widgets/custom_back_button.dart';
import 'package:tasky/features/home/domain/entities/task_entity.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_state.dart';
import 'package:tasky/features/home/presentation/widgets/update_task_view_body.dart';

class UpdateTaskView extends StatefulWidget {
  const UpdateTaskView({super.key, required this.taskEntity});

  final TaskEntity taskEntity;

  @override
  State<UpdateTaskView> createState() => _UpdateTaskViewState();
}

class _UpdateTaskViewState extends State<UpdateTaskView> {

  @override
  void initState() {
    TaskOperationsCubit.get(context).titleController.text=widget.taskEntity.title;
    TaskOperationsCubit.get(context).descriptionController.text=widget.taskEntity.description;
    TaskOperationsCubit.get(context).status=widget.taskEntity.status;
    TaskOperationsCubit.get(context).priority=widget.taskEntity.priority;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskOperationsCubit,TaskOperationsState>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is UpdateTaskLoadingState||
              state is UploadImageLoadingState ||
              state is UploadImageSuccessState,
          color: Colors.white,
          opacity: 0.5,
          progressIndicator: const CircularProgressIndicator(),
          child: Scaffold(
            appBar: AppBar(
              leading: const CustomBackButton(),
              title: const Text(AppStrings.editTask),
            ),
            body:  UpdateTaskViewBody(taskEntity: widget.taskEntity),
          ),
        );
      },
    );
  }
}
