
import 'package:tasky/features/profile/data/models/profile_model/profile_model.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class GetUserProfileLoadingState extends ProfileState {}

class GetUserProfileSuccessState extends ProfileState {
  final ProfileModel profileModel;

  GetUserProfileSuccessState(this.profileModel);
}

class GetUserProfileFailureState extends ProfileState {
  final String error;

  GetUserProfileFailureState(this.error);
}
