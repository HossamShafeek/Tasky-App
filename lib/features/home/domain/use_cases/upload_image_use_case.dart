import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/core/use_case/use_case.dart';
import 'package:tasky/features/home/domain/repository/home_repository.dart';

class UploadImageUseCase extends UseCase<String, File>{

final HomeRepository homeRepository;

  UploadImageUseCase({required this.homeRepository});

  @override
  Future<Either<Failure, String>> call(File params) async{
  return await homeRepository.uploadImage(image: params);
  }
}
