import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tasky/features/profile/data/repositry/profile_repository.dart';
import 'package:tasky/features/profile/presentation/cubits/profile_cubit/profile_state.dart';


class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepository)
      : super(ProfileInitialState());

  final ProfileRepository profileRepository;

  static ProfileCubit get(context) => BlocProvider.of(context);

  ProfileModel? profileModel;

  Future<void> getUserProfile() async {
    emit(GetUserProfileLoadingState());
    Either<Failure, ProfileModel> result;
    result = await profileRepository.getUserProfile();
    result.fold((failure) {
      emit(GetUserProfileFailureState(failure.error));
    }, (profileModel) {
      this.profileModel = profileModel;
      emit(GetUserProfileSuccessState(profileModel));
    });
  }
}
