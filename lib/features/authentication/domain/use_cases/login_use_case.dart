import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/core/use_case/use_case.dart';
import 'package:tasky/features/authentication/domain/entities/authentication_entity.dart';
import 'package:tasky/features/authentication/domain/repository/authentication_repository.dart';

class LoginUseCase  extends UseCase<AuthenticationEntity, LoginParams>{
   
   final AuthenticationRepository authenticationRepository;
  LoginUseCase({required this.authenticationRepository});

  @override
  Future<Either<Failure, AuthenticationEntity>> call(LoginParams params)async {
    return authenticationRepository.login(loginParams: params);
  }
}