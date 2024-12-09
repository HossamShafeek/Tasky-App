import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/widgets/custom_empty_widget.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_state.dart';
import 'package:tasky/features/home/presentation/views/widgets/task_list_view_item.dart';

class WaitingTasksListView extends StatefulWidget {
  const WaitingTasksListView({super.key});

  @override
  State<WaitingTasksListView> createState() => _WaitingTasksListViewState();
}

class _WaitingTasksListViewState extends State<WaitingTasksListView> {
  @override
  void initState() {
    TasksCubit.get(context).filterTasksList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (TasksCubit.get(context).waiting.isNotEmpty) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: AppConstants.size5h,
              bottom: AppConstants.size10h,
            ),
            itemCount: TasksCubit.get(context).waiting.length,
            itemBuilder: (context, index) => TaskListViewItem(
              taskModel: TasksCubit.get(context).waiting[index],
            ),
          );
        } else {
          return CustomEmptyWidget(
            imagePath: AppAssets.emptyTasks,
            title: AppStrings.emptyTasksTitle,
            subtitle: AppStrings.emptyTasksSubtitle,
          );
        }
      },
    );
  }
}


