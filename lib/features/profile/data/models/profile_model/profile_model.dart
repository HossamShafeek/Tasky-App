class ProfileModel {
  final String id;
  final String displayName;
  final String username;
  final List<String> roles;
  final bool active;
  final num experienceYears;
  final String address;
  final String experienceLevel;
  final String createdAt;
  final String updatedAt;
  final num v;

  ProfileModel({
  required this.id,
  required this.displayName,
  required this.username,
  required this.roles,
  required this.active,
  required this.experienceYears,
  required this.address,
  required this.experienceLevel,
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
