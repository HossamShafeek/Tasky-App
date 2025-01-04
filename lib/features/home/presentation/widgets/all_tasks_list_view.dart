import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tasky/core/functions/show_snack_bar.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/widgets/custom_empty_widget.dart';
import 'package:tasky/core/widgets/custom_error_widget.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_state.dart';
import 'package:tasky/features/home/presentation/widgets/task_list_view_item.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class AllTasksListView extends StatelessWidget {
  const AllTasksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {
        if(state is GetTasksSuccessState){
          if(state.tasks.isEmpty){
            showInfoSnackBar(context: context, message: 'There are no more tasks!');
          }
        }
      },
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
                  child: LiquidPullToRefresh(
                   onRefresh: ()async{
                     TasksCubit.get(context).pageNumber=1;
                     TasksCubit.get(context).getTasks();
                   },
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        top: AppConstants.size5h,
                        bottom: AppConstants.size10h,
                      ),
                      itemCount: TasksCubit.get(context).tasks.length,
                      itemBuilder: (context, index) => TaskListViewItem(
                        taskEntity: TasksCubit.get(context).tasks[index],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<TasksCubit,TasksState>(
                  buildWhen: (previous, current) => current is GetTasksLoadingFromPaginationState||current is GetTasksSuccessState||current is GetTasksFailureState,
                  builder: (context, state) {
                    if(state is GetTasksLoadingFromPaginationState){
                       return Lottie.asset(
                        AppAssets.loading,
                         height: AppConstants.size45h,
                      );
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
