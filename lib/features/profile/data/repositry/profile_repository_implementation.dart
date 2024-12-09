import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/api/api_services.dart';
import 'package:tasky/core/api/api_services_implementation.dart';
import 'package:tasky/core/api/end_points.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tasky/features/profile/data/repositry/profile_repository.dart';


class ProfileRepositoryImplementation extends ProfileRepository {
  final ApiServices apiServices;

  ProfileRepositoryImplementation(this.apiServices);

  @override
  Future<Either<Failure, ProfileModel>> getUserProfile() async {
    try {
      Response data = await apiServices.get(
   endPoint:    EndPoints.getUserProfile,
      );
      return Right(ProfileModel.fromJson(data.data));
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}
