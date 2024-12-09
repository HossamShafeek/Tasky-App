import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/widgets/custom_back_button.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_state.dart';
import 'package:tasky/features/home/presentation/views/widgets/add_task_view_body.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  @override
  void initState() {
    TaskOperationsCubit.get(context).priority = 'medium';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskOperationsCubit, TaskOperationsState>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AddTaskLoadingState ||
              state is UploadImageLoadingState ||
              state is UploadImageSuccessState,
          color: Colors.white,
          opacity: 0.5,
          progressIndicator: const CircularProgressIndicator(),
          child: Scaffold(
            appBar: AppBar(
              leading: const CustomBackButton(),
              title: const Text(AppStrings.addNewTask),
            ),
            body: const AddTaskViewBody(),
          ),
        );
      },
    );
  }
}
