import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/home/data/models/task_model/task_model.dart';
import 'package:tasky/features/home/data/repository/home_repository.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final HomeRepository homeRepository;

  TasksCubit(this.homeRepository) : super(TasksInitialState());

  static TasksCubit get(BuildContext context) => BlocProvider.of(context);

  List<TaskModel> tasks = [];


  int pageNumber = 1;

  Future<void> getTasks() async {
    if(pageNumber==1){
      emit(GetTasksLoadingState());
    }else{
      emit(GetTasksLoadingFromPaginationState());
    }
    Either<Failure, List<TaskModel>> result =
        await homeRepository.getTasks(pageNumber: pageNumber);
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

  List<TaskModel> inProgress = [];
  List<TaskModel> waiting = [];
  List<TaskModel> finished = [];

  void filterTasksList(){
    inProgress=[];
    waiting=[];
    finished=[];
    for (TaskModel task in tasks) {
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

  TaskModel? taskById ;

  Future<void> getTaskById({required String taskId}) async {
      emit(GetTaskByIdLoadingState());
    Either<Failure, TaskModel> result =
    await homeRepository.getTaskById(taskId: taskId);
    result.fold((error) {
      emit(GetTaskByIdFailureState(error.error));
    }, (task) {
        taskById = task;
      emit(GetTaskByIdSuccessState(task));
    });
  }

}
