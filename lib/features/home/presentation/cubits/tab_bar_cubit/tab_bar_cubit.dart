import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/home/presentation/cubits/tab_bar_cubit/tab_bar_state.dart';
import 'package:tasky/features/home/presentation/widgets/all_tasks_list_view.dart';
import 'package:tasky/features/home/presentation/widgets/finished_tasks_list_view.dart';
import 'package:tasky/features/home/presentation/widgets/in_progress_tasks_list_view.dart';
import 'package:tasky/features/home/presentation/widgets/waiting_tasks_list_view.dart';


class TabBarCubit extends Cubit<TabBarState> {
  TabBarCubit() : super(TabBarInitialState());

  static TabBarCubit get(BuildContext context) => BlocProvider.of(context);

  int index = 0;

  List<String> tabs=const[
    'All',
    'In Progress',
    'Waiting',
    'Finished',
  ];
  List<Widget> views=const[
    AllTasksListView(),
    InProgressTasksListView(),
    WaitingTasksListView(),
    FinishedTasksListView(),
  ];

  void changeTabBarIndex(int index){
    this.index=index;
    emit(ChangeTabBarIndexState());
  }

}
