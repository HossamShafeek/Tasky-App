import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/core/use_case/use_case.dart';
import 'package:tasky/features/home/domain/entities/task_entity.dart';
import 'package:tasky/features/home/domain/repository/home_repository.dart';

class GetTaskByIdUseCase extends UseCase<TaskEntity, String>{
  final HomeRepository homeRepository;
  GetTaskByIdUseCase({required this.homeRepository});
  @override
  Future<Either<Failure, TaskEntity>> call(String params) async{
    return await homeRepository.getTaskById(taskId: params);
  }
}