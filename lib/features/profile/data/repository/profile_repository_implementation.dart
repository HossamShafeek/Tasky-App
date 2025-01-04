import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:tasky/features/profile/domain/entities/profile_entity.dart';
import 'package:tasky/features/profile/domain/repository/profile_repository.dart';


class ProfileRepositoryImplementation extends ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImplementation({required this.profileRemoteDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> getUserProfile() async {
    try {
     ProfileEntity profileEntity =await profileRemoteDataSource.getUserProfile();
      return Right(profileEntity);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}
