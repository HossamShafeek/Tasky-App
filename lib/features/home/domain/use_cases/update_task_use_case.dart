import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/core/use_case/use_case.dart';
import 'package:tasky/features/home/domain/repository/home_repository.dart';

class UpdateTaskUseCase  extends  UseCase<String, UpdateTaskParams>{
 
 final HomeRepository homeRepository; 

  UpdateTaskUseCase({required this.homeRepository});

  @override
  Future<Either<Failure, String>> call(UpdateTaskParams params)async {
   return await homeRepository.updateTask(updateTaskParams: params);
  }

}