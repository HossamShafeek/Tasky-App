import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/api/api_services.dart';
import 'package:tasky/core/api/api_services_implementation.dart';
import 'package:tasky/core/api/end_points.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/authentication/data/models/authentication_model.dart';
import 'package:tasky/features/authentication/data/repository/authentication_repository.dart';

class AuthenticationRepositoryImplementation extends AuthenticationRepository {
  final ApiServices apiServices;

  AuthenticationRepositoryImplementation(this.apiServices);

  @override
  Future<Either<Failure, AuthenticationModel>> register({
    required String fullName,
    required String phone,
    required String address,
    required num experienceYears,
    required String experienceLevel,
    required String password,
  }) async {
    try {
      Response data =
          await apiServices.post(endPoint:  EndPoints.register, data: {
        'displayName': fullName,
        'phone': phone,
        'password': password,
        'experienceYears': experienceYears,
        'level': experienceLevel,
        'address': address,
      });

      return Right(AuthenticationModel.fromJson(data.data));
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, AuthenticationModel>> login({
    required String phone,
    required String password,
  }) async {
    try {
      Response data = await apiServices.post(
        endPoint:  EndPoints.login,
        data: {
          'phone': phone,
          'password': password,
        },
      );
      return Right(AuthenticationModel.fromJson(data.data));
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}
