
import 'package:tasky/features/authentication/data/models/authentication_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final AuthenticationModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState(this.error);
}

class LoginChangePasswordVisibilityState extends LoginState {}
class LoginChangeSelectedPhoneNumberState extends LoginState {}

