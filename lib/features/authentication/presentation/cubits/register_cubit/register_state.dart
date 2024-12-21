import 'package:tasky/features/authentication/domain/entities/authentication_entity.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final AuthenticationEntity registerEntity;

  RegisterSuccessState(this.registerEntity);
}

class RegisterFailureState extends RegisterState {
  final String error;

  RegisterFailureState(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterState {}

class RegisterChangeSelectedPhoneNumberState extends RegisterState {}
class RegisterSelectExperienceLevelState extends RegisterState {}
