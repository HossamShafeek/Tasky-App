import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tasky/core/api/api_services.dart';
import 'package:tasky/core/api/end_points.dart';
import 'package:tasky/features/home/data/models/task_model/task_model.dart';
import 'package:tasky/features/home/domain/entities/task_entity.dart';
import 'package:tasky/features/home/domain/repository/home_repository.dart';

abstract class HomeRemoteDataSource {
  Future<List<TaskEntity>> getTasks({required int pageNumber});
  Future<TaskEntity> getTaskById({required String taskId});
  Future<String> addTask({
    required AddTaskParams addTaskParams,
  });
  Future<String> updateTask({
    required UpdateTaskParams updateTaskParams,
  });
  Future<String> deleteTask({required String taskId});
  Future<String> uploadImage({required File image});
  
}

class HomeRemoteDataSourceImplementation implements HomeRemoteDataSource {

  final ApiServices apiServices;

  HomeRemoteDataSourceImplementation({required this.apiServices});

   @override
  Future<TaskEntity> getTaskById({required String taskId})async {
   Response data = await apiServices.get(
        endPoint: '${EndPoints.getTaskById}$taskId',
      );
      TaskEntity task = TaskModel.fromJson(data.data);
      return task;
  }

  @override
  Future<List<TaskEntity>> getTasks({required int pageNumber}) async{
   Response data = await apiServices.get(
        endPoint: '${EndPoints.getTasks}$pageNumber',
      );
      List<TaskEntity> tasks = (data.data as List<dynamic>).map((task) {
        return TaskModel.fromJson(task);
   
     }).toList();
 return tasks;
  }

  @override
  Future<String> uploadImage({required File image})async {
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
          return response.data['image'];
  }

  @override
  Future<String> addTask({required AddTaskParams addTaskParams}) async{
     await apiServices.post(endPoint: EndPoints.addTask, data: {
        'title': addTaskParams.title,
        'desc': addTaskParams.description,
        'image': addTaskParams.image,
        'priority': addTaskParams.priority,
        'dueDate': addTaskParams.dueDate,
      });
      return 'Added task successfully';
  }
  @override
  Future<String> updateTask({required UpdateTaskParams updateTaskParams})async {
     await apiServices.put(endPoint: EndPoints.updateTask+updateTaskParams.taskId, data: {
        'title': updateTaskParams.title,
        'desc': updateTaskParams.description,
        'image': updateTaskParams.image,
        'priority': updateTaskParams.priority,
        'status': updateTaskParams.status,
      });
      return 'Update task successfully';
  }


  @override
  Future<String> deleteTask({required String taskId})async {
       await apiServices.delete(endPoint: EndPoints.deleteTask+taskId);
      return 'Delete task successfully';
  }

 





}