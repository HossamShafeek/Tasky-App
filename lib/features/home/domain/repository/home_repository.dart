import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/home/domain/entities/task_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks({required int pageNumber});

  Future<Either<Failure, TaskEntity>> getTaskById({required String taskId});

  Future<Either<Failure, String>> uploadImage({required File image});

  Future<Either<Failure, String>> addTask({
    required AddTaskParams addTaskParams,
  });
  Future<Either<Failure, String>> updateTask({
    required UpdateTaskParams updateTaskParams,
  });

  Future<Either<Failure, String>> deleteTask({required String taskId});

}


class AddTaskParams {
  final String title;
  final String description;
  final String priority;
  final String dueDate;
  final String image;
  AddTaskParams({
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    required this.image,
  });
}

class UpdateTaskParams {
  final String title;
  final String description;
  final String priority;
  final String status;
  final String image;
  final String taskId;
  UpdateTaskParams({
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.image,
    required this.taskId,
  });
}