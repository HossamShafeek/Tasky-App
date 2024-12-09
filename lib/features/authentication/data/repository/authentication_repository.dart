import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/authentication/data/models/authentication_model.dart';


abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticationModel>> register({
    required String fullName,
    required String phone,
    required String address,
    required num experienceYears,
    required String experienceLevel,
    required String password,
  });
  Future<Either<Failure, AuthenticationModel>> login({
    required String phone,
    required String password,
  });
}
