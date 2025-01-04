import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getUserProfile();
}