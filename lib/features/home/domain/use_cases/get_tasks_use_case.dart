import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/core/use_case/use_case.dart';
import 'package:tasky/features/home/domain/entities/task_entity.dart';
import 'package:tasky/features/home/domain/repository/home_repository.dart';

class GetTasksUseCase extends UseCase<List<TaskEntity>, int >{

final HomeRepository homeRepository;

  GetTasksUseCase({required this.homeRepository});
  
  @override
  Future<Either<Failure, List<TaskEntity>>> call(int params) async{
    return await homeRepository.getTasks(pageNumber: params);

  }


}