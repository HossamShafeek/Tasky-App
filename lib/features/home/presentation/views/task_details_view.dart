import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky/config/routes/app_routes.dart';
import 'package:tasky/core/functions/show_snack_bar.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/widgets/custom_back_button.dart';
import 'package:tasky/features/home/data/models/task_model/task_model.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_state.dart';
import 'package:tasky/features/home/presentation/views/widgets/popup_menu_buttons_section.dart';
import 'package:tasky/features/home/presentation/views/widgets/task_details_view_body.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskOperationsCubit,TaskOperationsState>(
      listener: (context, state) {
        if(state is DeleteTaskSuccessState){
          showSuccessSnackBar(context: context, message: state.message);
          Navigator.pushNamedAndRemoveUntil(context, Routes.homeView,(route) => false,);
        }else if(state is DeleteTaskFailureState){
          showErrorSnackBar(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return  ModalProgressHUD(
          inAsyncCall: state is DeleteTaskLoadingState,
          color: Colors.white,
          opacity: 0.5,
          progressIndicator: const CircularProgressIndicator(),
          child: Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.taskDetails),
              leading: const CustomBackButton(),
              actions:  [
                PopupMenuButtonsSection(taskModel: taskModel),
              ],
            ),
            body: TaskDetailsViewBody(
              taskModel: taskModel,
            ),
          ),
        );
      },
    );
  }
}
