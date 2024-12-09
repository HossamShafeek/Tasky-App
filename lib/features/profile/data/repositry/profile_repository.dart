import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/profile/data/models/profile_model/profile_model.dart';


abstract class ProfileRepository {
  Future<Either<Failure, ProfileModel>> getUserProfile();
}
