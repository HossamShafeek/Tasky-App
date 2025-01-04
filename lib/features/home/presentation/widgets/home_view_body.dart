import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/shimmer/shimmer_task_list_view.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_error_widget.dart';
import 'package:tasky/core/widgets/no_internet_widget.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_state.dart';
import 'package:tasky/features/home/presentation/widgets/custom_tab_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppConstants.defaultPadding,
        right: AppConstants.defaultPadding,
        top: AppConstants.defaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.myTasks,
            style: AppStyles.styleBold16Black.copyWith(
              color: AppColors.grey,
            ),
          ),
          BlocBuilder<TasksCubit, TasksState>(
            buildWhen: (previous, current) =>
                current is GetTasksSuccessState ||
                current is GetTasksFailureState ||
                current is GetTasksLoadingState,
            builder: (context, state) {
              if (state is GetTasksSuccessState) {
                return const CustomTabBar();
              } else if (state is GetTasksFailureState) {
                if(state.error.contains('internet connection')){
                  return NoInternetWidget(onPressed: (){
                    TasksCubit.get(context).getTasks();
                  });
                }else{
                  return CustomErrorWidget(error: state.error);
                }
              } else {
                return const ShimmerTaskListView();
              }
            },
          ),
        ],
      ),
    );
  }
}
