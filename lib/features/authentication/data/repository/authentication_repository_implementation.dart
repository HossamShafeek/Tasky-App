import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:tasky/features/authentication/domain/entities/authentication_entity.dart';
import 'package:tasky/features/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImplementation extends AuthenticationRepository {
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;

  AuthenticationRepositoryImplementation({required this.authenticationRemoteDataSource});

  @override
  Future<Either<Failure, AuthenticationEntity>> register({
    required RegisterParams registerParams,
  }) async {
    try {
     AuthenticationEntity authenticationEntity = await authenticationRemoteDataSource.register(registerParams: registerParams);
      return Right(authenticationEntity);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, AuthenticationEntity>> login({
    required LoginParams loginParams,
  }) async {
    try {
      AuthenticationEntity authenticationEntity = await authenticationRemoteDataSource.login(loginParams: loginParams);
      return Right(authenticationEntity);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}
