
import 'package:tasky/features/authentication/domain/entities/authentication_entity.dart';

class AuthenticationModel extends AuthenticationEntity {
 

  AuthenticationModel({required super.accessToken,required super.refreshToken,required super.id,});

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(

      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      id: json['_id'] as String,
    );
  }

}