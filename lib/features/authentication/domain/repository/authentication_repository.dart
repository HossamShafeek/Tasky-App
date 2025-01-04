import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/authentication/domain/entities/authentication_entity.dart';


abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticationEntity>> register({
    required RegisterParams registerParams,
  });
  Future<Either<Failure, AuthenticationEntity>> login({
    required LoginParams loginParams,
  });
}

class  LoginParams {
  final String phone;
  final String password;

  LoginParams({required this.phone, required this.password});
}

class  RegisterParams {
  final String fullName;  
  final String phone;
  final String address;
  final num experienceYears;
  final String experienceLevel;
  final String password;

  RegisterParams({required this.fullName, required this.phone, required this.address, required this.experienceYears, required this.experienceLevel, required this.password});
  
}