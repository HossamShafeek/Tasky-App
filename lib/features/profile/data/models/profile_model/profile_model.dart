import 'package:tasky/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity{
  final String id;
  final List<String> roles;
  final bool active;
  final String createdAt;
  final String updatedAt;
  final num v;

  ProfileModel({
   required this.id,
  required super.displayName,
 required super.username,
  required this.roles,
  required this.active,
 required super.experienceYears,
  required super.address,
  required super.experienceLevel,
  required this.createdAt,
  required this.updatedAt,
  required this.v,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json['_id'] as String,
    displayName: json['displayName'] as String,
    username: json['username'] as String,
    roles: json['roles'].cast<String>(),
    active: json['active'] as bool,
    experienceYears: json['experienceYears'] as num,
    address: json['address'] as String,
    experienceLevel: json['level'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    v: json['__v'] as num,
      );
}
