import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/api/api_services.dart';
import 'package:tasky/core/api/end_points.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/home/data/models/task_model/task_model.dart';
import 'package:tasky/features/home/data/repository/home_repository.dart';

class HomeRepositoryImplementation extends HomeRepository {
  final ApiServices apiServices;

  HomeRepositoryImplementation(this.apiServices);

  @override
  Future<Either<Failure, List<TaskModel>>> getTasks(
      {required int pageNumber}) async {
    try {
      Response data = await apiServices.get(
        endPoint: '${EndPoints.getTasks}$pageNumber',
      );
      List<TaskModel> tasks = (data.data as List<dynamic>).map((task) {
        return TaskModel.fromJson(task);
      }).toList();
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
  Future<Either<Failure, TaskModel>> getTaskById(
      {required String taskId}) async {
    try {
      Response data = await apiServices.get(
        endPoint: '${EndPoints.getTaskById}$taskId',
      );
      TaskModel task = TaskModel.fromJson(data.data);
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
      FormData formData = FormData();
      formData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
            contentType:
                DioMediaType.parse("image/${image.path.split('.').last}"),
          )));

      final response = await apiServices.post(
          endPoint: EndPoints.uploadImage, data: formData);
      return right(response.data['image']);
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
    required String title,
    required String description,
    required String priority,
    required String dueDate,
    required String image,
  }) async {
    try {
      await apiServices.post(endPoint: EndPoints.addTask, data: {
        'title': title,
        'desc': description,
        'image': image,
        'priority': priority,
        'dueDate': dueDate,
      });
      return right('Added task successfully');
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
    required String title,
    required String description,
    required String priority,
    required String status,
    required String image,
    required String taskId,
  }) async {
    try {
      await apiServices.put(endPoint: EndPoints.updateTask+taskId, data: {
        'title': title,
        'desc': description,
        'image': image,
        'priority': priority,
        'status': status,
      });
      return right('Update task successfully');
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
      await apiServices.delete(endPoint: EndPoints.deleteTask+taskId);
      return right('Delete task successfully');
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}
