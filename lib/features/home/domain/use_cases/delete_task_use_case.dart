import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/core/use_case/use_case.dart';
import 'package:tasky/features/home/domain/repository/home_repository.dart';

class DeleteTaskUseCase extends UseCase<String,String>{
 
 final HomeRepository homeRepository;
  DeleteTaskUseCase({required this.homeRepository});

  @override
  Future<Either<Failure, String>> call(String params) async{
    return await homeRepository.deleteTask(taskId: params);
  }
}