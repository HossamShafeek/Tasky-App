import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/home/data/models/task_model/task_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<TaskModel>>> getTasks({required int pageNumber});

  Future<Either<Failure, TaskModel>> getTaskById({required String taskId});

  Future<Either<Failure, String>> uploadImage({required File image});

  Future<Either<Failure, String>> addTask({
    required String title,
    required String description,
    required String priority,
    required String dueDate,
    required String image,
  });
  Future<Either<Failure, String>> updateTask({
    required String title,
    required String description,
    required String priority,
    required String status,
    required String image,
    required String taskId,
  });

  Future<Either<Failure, String>> deleteTask({required String taskId});

}
