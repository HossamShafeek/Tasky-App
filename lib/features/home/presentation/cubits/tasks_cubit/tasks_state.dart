import 'package:tasky/features/home/domain/entities/task_entity.dart';

abstract class TasksState{

}

class TasksInitialState extends TasksState{}

class GetTasksLoadingState extends TasksState {}

class GetTasksSuccessState extends TasksState {
  final List<TaskEntity> tasks;

  GetTasksSuccessState(this.tasks);
}

class GetTasksFailureState extends TasksState {
  final String error;

  GetTasksFailureState(this.error);
}

class GetTasksLoadingFromPaginationState extends TasksState {}



class GetTaskByIdLoadingState extends TasksState {}

class GetTaskByIdSuccessState extends TasksState {
  final TaskEntity task;

  GetTaskByIdSuccessState(this.task);
}

class GetTaskByIdFailureState extends TasksState {
  final String error;

  GetTaskByIdFailureState(this.error);
}