import 'package:dio/dio.dart';
import 'package:tasky/core/api/api_services.dart';
import 'package:tasky/core/api/end_points.dart';
import 'package:tasky/features/authentication/data/models/authentication_model.dart';
import 'package:tasky/features/authentication/domain/entities/authentication_entity.dart';
import 'package:tasky/features/authentication/domain/repository/authentication_repository.dart';




abstract class AuthenticationRemoteDataSource{

  Future<AuthenticationEntity> register({
    required RegisterParams registerParams,
  });

  Future<AuthenticationEntity> login({
    required LoginParams loginParams,
  });
}

class AuthenticationRemoteDataSourceImplementation extends AuthenticationRemoteDataSource{
  final ApiServices apiServices;
  AuthenticationRemoteDataSourceImplementation({required this.apiServices});
  @override
  Future<AuthenticationEntity> login({required LoginParams loginParams}) async{
       Response data = await apiServices.post(
        endPoint:  EndPoints.login,
        data: {
          'phone': loginParams.phone,
          'password': loginParams.password,
        },
      );
      AuthenticationEntity authenticationEntity = parsAuthenticationData(data);
      return authenticationEntity;    
  }


  @override
  Future<AuthenticationEntity> register({required RegisterParams registerParams}) async{
    Response data = await apiServices.post(
      endPoint:  EndPoints.register,
      data: {
        'displayName': registerParams.fullName,
        'phone': registerParams.phone,
        'password': registerParams.password,
        'experienceYears': registerParams.experienceYears,
        'level': registerParams.experienceLevel,
        'address': registerParams.address,
      },    
    );
    AuthenticationEntity authenticationEntity = parsAuthenticationData(data);
    return authenticationEntity;
  }

  
  AuthenticationEntity parsAuthenticationData(Response response) {
    return AuthenticationModel.fromJson(response.data);
  }

  }



