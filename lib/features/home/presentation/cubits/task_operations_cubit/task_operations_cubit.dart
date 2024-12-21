import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/home/domain/repository/home_repository.dart';
import 'package:tasky/features/home/domain/use_cases/add_task_use_case.dart';
import 'package:tasky/features/home/domain/use_cases/delete_task_use_case.dart';
import 'package:tasky/features/home/domain/use_cases/update_task_use_case.dart';
import 'package:tasky/features/home/domain/use_cases/upload_image_use_case.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_state.dart';
import 'package:image_picker/image_picker.dart';

class TaskOperationsCubitParams {
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
    final UploadImageUseCase uploadImageUseCase;

  TaskOperationsCubitParams({required this.addTaskUseCase, required this.updateTaskUseCase, required this.deleteTaskUseCase, required this.uploadImageUseCase});
}

class TaskOperationsCubit extends Cubit<TaskOperationsState> {

final TaskOperationsCubitParams taskOperationsCubitParams;

  TaskOperationsCubit({required this.taskOperationsCubitParams})
      : super(TaskOperationsInitialState());

  static TaskOperationsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  String priority = '';
  String status = '';

  File? image;

  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    emit(SelectImageState());
  }

  Future getImageFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    emit(SelectImageState());
  }

  void selectDueDate({required String dueDate}) {
    dueDateController.text = dueDate;
    emit(SelectDueDateState());
  }

   String uploadImagePath = '';

  Future<void> uploadImage() async {
    emit(UploadImageLoadingState());
    Either<Failure, String> resultForImage =
        await taskOperationsCubitParams.uploadImageUseCase.call(image!);
    resultForImage.fold(
      (error) {
        if(error.error.contains('Opps')){
          emit(UploadImageFailureState('Image size is large'));
        }else{
          emit(UploadImageFailureState(error.error));
        }
      },
      (imagePath) async {
        uploadImagePath = imagePath;
        emit(UploadImageSuccessState(imagePath));
      },
    );
  }

  Future<void> addTask() async {
    emit(AddTaskLoadingState());
    Either<Failure, String> result = await taskOperationsCubitParams.addTaskUseCase.call(
      AddTaskParams(
        title: titleController.text,
      description: descriptionController.text,
      priority: priority,
      image: uploadImagePath,
      dueDate: dueDateController.text,
      ),
    );
    result.fold(
      (error) {
        emit(AddTaskFailureState(error.error));
      },
      (message) {
        emit(AddTaskSuccessState(message));
      },
    );
  }

  Future<void> updateTask(
      {required String taskId,
      required String imageFromModel,}) async {
    emit(UpdateTaskLoadingState());
    Either<Failure, String> result =
        await taskOperationsCubitParams.updateTaskUseCase.call(
      UpdateTaskParams(
        title: titleController.text,
      description: descriptionController.text,
      priority: priority,
      image: image != null ? uploadImagePath : imageFromModel,
      status: status,
      taskId: taskId,
      )
    );
    result.fold(
      (error) {
        emit(UpdateTaskFailureState(error.error));
      },
      (message) {
        emit(UpdateTaskSuccessState(message));
      },
    );
  }

  Future<void> deleteTask(
      {required String taskId,}) async {
    emit(DeleteTaskLoadingState());
    Either<Failure, String> result =
        await taskOperationsCubitParams.deleteTaskUseCase.call(
       taskId,
    );
    result.fold(
      (error) {
        emit(DeleteTaskFailureState(error.error));
      },
      (message) {
        emit(DeleteTaskSuccessState(message));
      },
    );
  }
}
