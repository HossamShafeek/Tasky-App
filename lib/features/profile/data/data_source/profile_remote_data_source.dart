import 'package:dio/dio.dart';
import 'package:tasky/core/api/api_services.dart';
import 'package:tasky/core/api/end_points.dart';
import 'package:tasky/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tasky/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileEntity> getUserProfile();
}

class ProfileRemoteDataSourceImplementation extends ProfileRemoteDataSource {
  
 final ApiServices apiServices;

  ProfileRemoteDataSourceImplementation({required this.apiServices});

  Future<ProfileEntity> parsProfileData(Response response)async{

ProfileEntity profileEntity = ProfileModel.fromJson(response.data);
return profileEntity;
  }


  @override
  Future<ProfileEntity> getUserProfile() async{
    Response response = await apiServices.get(endPoint: EndPoints.getUserProfile);
       ProfileEntity profileEntity = await parsProfileData(response);();
       return profileEntity;
  }

}