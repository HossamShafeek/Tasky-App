import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/shimmer/shimmer_task_list_view_item.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/widgets/custom_empty_widget.dart';
import 'package:tasky/core/widgets/custom_error_widget.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_state.dart';
import 'package:tasky/features/home/presentation/views/widgets/task_list_view_item.dart';

class AllTasksListView extends StatelessWidget {
  const AllTasksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (TasksCubit.get(context).tasks.isNotEmpty) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent &&
                  notification is ScrollUpdateNotification) {
                TasksCubit.get(context).getTasks();
              }
              return true;
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: AppConstants.size5h,
                      bottom: AppConstants.size10h,
                    ),
                    itemCount: TasksCubit.get(context).tasks.length,
                    itemBuilder: (context, index) => TaskListViewItem(
                      taskModel: TasksCubit.get(context).tasks[index],
                    ),
                  ),
                ),
                BlocBuilder<TasksCubit,TasksState>(
                  buildWhen: (previous, current) => current is GetTasksLoadingFromPaginationState||current is GetTasksSuccessState||current is GetTasksFailureState,
                  builder: (context, state) {
                    if(state is GetTasksLoadingFromPaginationState){
                      return const ShimmerTaskListViewItem();
                    }else if(state is GetTasksFailureState){
                      return CustomErrorWidget(error: state.error);
                    }
                    else{
                     return const SizedBox.shrink();
                    }
                  },
                )
              ],
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
