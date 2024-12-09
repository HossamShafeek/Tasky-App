class TaskModel {
  final String id;
  final String? image;
  final String title;
  final String description;
  final String priority;
  final String status;
  final String userId;
  final String createdAt;
  final String updatedAt;
  final num? v;

  TaskModel({
    required  this.id,
     this.image,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.userId,
    required  this.createdAt,
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
