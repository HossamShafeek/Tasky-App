
import 'package:tasky/features/authentication/domain/entities/authentication_entity.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final AuthenticationEntity loginEntity;

  LoginSuccessState(this.loginEntity);
}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState(this.error);
}

class LoginChangePasswordVisibilityState extends LoginState {}
class LoginChangeSelectedPhoneNumberState extends LoginState {}

