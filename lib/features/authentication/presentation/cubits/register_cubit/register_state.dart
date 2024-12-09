import 'package:tasky/features/authentication/data/models/authentication_model.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final AuthenticationModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterFailureState extends RegisterState {
  final String error;

  RegisterFailureState(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterState {}

class RegisterChangeSelectedCountryState extends RegisterState {}
class RegisterSelectExperienceLevelState extends RegisterState {}
