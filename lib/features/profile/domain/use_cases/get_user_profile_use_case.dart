import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/core/use_case/use_case.dart';
import 'package:tasky/features/profile/domain/entities/profile_entity.dart';
import 'package:tasky/features/profile/domain/repository/profile_repository.dart';

class GetUserProfileUseCase extends UseCase<ProfileEntity, NoParams>{
  final ProfileRepository profileRepository;
GetUserProfileUseCase({required this.profileRepository});
        
  @override
  Future<Either<Failure, ProfileEntity>> call([NoParams? params]) async{
    return await profileRepository.getUserProfile();
}
}