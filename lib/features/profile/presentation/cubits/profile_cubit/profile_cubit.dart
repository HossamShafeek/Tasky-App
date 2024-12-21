import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/profile/domain/entities/profile_entity.dart';
import 'package:tasky/features/profile/domain/use_cases/get_user_profile_use_case.dart';
import 'package:tasky/features/profile/presentation/cubits/profile_cubit/profile_state.dart';


class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.fetchProfileDataUseCase})
      : super(ProfileInitialState());

  final GetUserProfileUseCase fetchProfileDataUseCase;

  static ProfileCubit get(context) => BlocProvider.of(context);

  ProfileEntity? profileEntity;

  Future<void> getUserProfile() async {
    emit(GetUserProfileLoadingState());
    Either<Failure, ProfileEntity> result;
    result = await fetchProfileDataUseCase.call();
    result.fold((failure) {
      emit(GetUserProfileFailureState(failure.error));
    }, (profileEntity) {
      this.profileEntity = profileEntity;
      emit(GetUserProfileSuccessState(profileEntity));
    });
  }
}
