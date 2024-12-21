import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/home/domain/entities/task_entity.dart';
import 'package:tasky/features/home/domain/use_cases/get_task_by_id_use_case.dart';
import 'package:tasky/features/home/domain/use_cases/get_tasks_use_case.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_state.dart';


class TasksCubitParams{
  final GetTasksUseCase getTasksUseCase;
  final GetTaskByIdUseCase getTaskByIdUseCase;

  TasksCubitParams({required this.getTasksUseCase, required this.getTaskByIdUseCase});
}

class TasksCubit extends Cubit<TasksState> {
  final TasksCubitParams tasksCubitParams;

  TasksCubit({required this.tasksCubitParams}) : super(TasksInitialState());

  static TasksCubit get(BuildContext context) => BlocProvider.of(context);

  List<TaskEntity> tasks = [];


  int pageNumber = 1;

  Future<void> getTasks() async {
    if(pageNumber==1){
      emit(GetTasksLoadingState());
    }else{
      emit(GetTasksLoadingFromPaginationState());
    }
    Either<Failure, List<TaskEntity>> result =
        await tasksCubitParams.getTasksUseCase.call(pageNumber);
    result.fold((error) {
      emit(GetTasksFailureState(error.error));
    }, (tasks) {
      if(pageNumber ==1){
        this.tasks = tasks;
        pageNumber++;
      }
      else if(tasks.isNotEmpty){
        this.tasks.addAll(tasks);
        pageNumber++;
      }
      emit(GetTasksSuccessState(tasks));
    });
  }

  List<TaskEntity> inProgress = [];
  List<TaskEntity> waiting = [];
  List<TaskEntity> finished = [];

  void filterTasksList(){
    inProgress=[];
    waiting=[];
    finished=[];
    for (TaskEntity task in tasks) {
      switch(task.status.toLowerCase().replaceAll(' ', '')){
        case 'inprogress':
          inProgress.add(task);
        case'waiting':
          waiting.add(task);
        default:
          finished.add(task);
      }
    }
  }

  TaskEntity? taskById ;

  Future<void> getTaskById({required String taskId}) async {
      emit(GetTaskByIdLoadingState());
    Either<Failure, TaskEntity> result =
    await tasksCubitParams.getTaskByIdUseCase.call(taskId);
    result.fold((error) {
      emit(GetTaskByIdFailureState(error.error));
    }, (task) {
        taskById = task;
      emit(GetTaskByIdSuccessState(task));
    });
  }

}
