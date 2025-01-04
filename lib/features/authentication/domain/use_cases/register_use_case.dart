
import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/core/use_case/use_case.dart';
import 'package:tasky/features/authentication/domain/entities/authentication_entity.dart';
import 'package:tasky/features/authentication/domain/repository/authentication_repository.dart';

class RegisterUseCase  extends UseCase<AuthenticationEntity, RegisterParams>{
   
   final AuthenticationRepository authenticationRepository;
  RegisterUseCase({required this.authenticationRepository});

  @override
  Future<Either<Failure, AuthenticationEntity>> call(RegisterParams params)async {
    return authenticationRepository.register(registerParams: params);
  }
}