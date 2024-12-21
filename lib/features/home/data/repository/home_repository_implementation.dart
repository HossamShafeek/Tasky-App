import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/home/data/date_source/home_remote_data_source.dart';
import 'package:tasky/features/home/domain/entities/task_entity.dart';
import 'package:tasky/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImplementation extends HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImplementation({required this.homeRemoteDataSource});

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks(
      {required int pageNumber}) async {
    try {
      List<TaskEntity> tasks = await homeRemoteDataSource.getTasks(pageNumber: pageNumber);
      return Right(tasks);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> getTaskById(
      {required String taskId}) async {
    try {
      TaskEntity task = await homeRemoteDataSource.getTaskById(taskId: taskId);
      return Right(task);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage({required File image}) async {
    try {
      String imagePath = await homeRemoteDataSource.uploadImage(image: image);
      return Right(imagePath);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, String>> addTask({
    required AddTaskParams addTaskParams,
  }) async {
    try {
     String addTaskMessage = await homeRemoteDataSource.addTask(addTaskParams: addTaskParams);
      return Right(addTaskMessage);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, String>> updateTask({
    required UpdateTaskParams updateTaskParams,})async{
    try {
     String updateTaskMessage = await homeRemoteDataSource.updateTask(updateTaskParams: updateTaskParams);
      return Right(updateTaskMessage);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, String>> deleteTask({required String taskId}) async{
    try {
    String deleteTaskMessage = await homeRemoteDataSource.deleteTask(taskId: taskId);
    return Right(deleteTaskMessage);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}
