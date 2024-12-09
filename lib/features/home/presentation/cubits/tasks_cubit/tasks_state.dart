import 'package:tasky/features/home/data/models/task_model/task_model.dart';

abstract class TasksState{

}

class TasksInitialState extends TasksState{}

class GetTasksLoadingState extends TasksState {}

class GetTasksSuccessState extends TasksState {
  final List<TaskModel> tasks;

  GetTasksSuccessState(this.tasks);
}

class GetTasksFailureState extends TasksState {
  final String error;

  GetTasksFailureState(this.error);
}

class GetTasksLoadingFromPaginationState extends TasksState {}



class GetTaskByIdLoadingState extends TasksState {}

class GetTaskByIdSuccessState extends TasksState {
  final TaskModel task;

  GetTaskByIdSuccessState(this.task);
}

class GetTaskByIdFailureState extends TasksState {
  final String error;

  GetTaskByIdFailureState(this.error);
}