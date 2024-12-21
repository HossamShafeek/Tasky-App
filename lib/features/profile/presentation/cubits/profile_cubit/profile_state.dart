
import 'package:tasky/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class GetUserProfileLoadingState extends ProfileState {}

class GetUserProfileSuccessState extends ProfileState {
  final ProfileEntity profileModel;

  GetUserProfileSuccessState(this.profileModel);
}

class GetUserProfileFailureState extends ProfileState {
  final String error;

  GetUserProfileFailureState(this.error);
}
