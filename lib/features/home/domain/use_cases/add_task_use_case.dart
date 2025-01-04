import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/core/use_case/use_case.dart';
import 'package:tasky/features/home/domain/repository/home_repository.dart';

class AddTaskUseCase extends UseCase<String, AddTaskParams>{
 
 final HomeRepository homeRepository;

  AddTaskUseCase({required this.homeRepository});

  @override
  Future<Either<Failure, String>> call(AddTaskParams params) async{
    return await homeRepository.addTask(addTaskParams: params);
  }
}