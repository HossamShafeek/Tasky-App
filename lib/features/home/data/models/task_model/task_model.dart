import 'package:tasky/features/home/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity{
  final String userId;
  final String updatedAt;
  final num? v;

  TaskModel({
    required  super.id,
     super.image,
    required super.title,
    required super.description,
    required super.priority,
    required super.status,
    required this.userId,
    required  super.createdAt,
    required  this.updatedAt,
    this.v,
  });

  factory TaskModel.fromJson(Map<String,dynamic>json) {
    return TaskModel(
      id: json['_id']as String,
      image: json['image']as String? ??'',
      title: json['title']as String,
      description: json['desc']as String,
      priority: json['priority']as String,
      status: json['status']as String,
      userId: json['user']as String,
      createdAt: json['createdAt']as String,
      updatedAt: json['updatedAt']as String,
      v: json['__v']as num?,
    );
  }

  Map<String,dynamic>toJson(){
    return {
      '_id':id,
      'image':image,
      'title':title,
      'desc':description,
      'priority':priority,
      'status':status,
      'user':userId,
      'createdAt':createdAt,
      'updatedAt':updatedAt,
      '__v':v,
    };
  }

}
