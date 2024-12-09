abstract class TaskOperationsState{}


class TaskOperationsInitialState extends TaskOperationsState{}

class AddTaskLoadingState extends TaskOperationsState{}

class AddTaskFailureState extends TaskOperationsState{
  final String error;

  AddTaskFailureState(this.error);
}

class AddTaskSuccessState extends TaskOperationsState{
  final String message;

  AddTaskSuccessState(this.message);
}

class UploadImageLoadingState extends TaskOperationsState{}

class UploadImageFailureState extends TaskOperationsState{
  final String error;

  UploadImageFailureState(this.error);
}

class UploadImageSuccessState extends TaskOperationsState{
  final String imagePath;

  UploadImageSuccessState(this.imagePath);
}

class UpdateTaskLoadingState extends TaskOperationsState{}

class UpdateTaskFailureState extends TaskOperationsState{
  final String error;

  UpdateTaskFailureState(this.error);
}

class UpdateTaskSuccessState extends TaskOperationsState{
  final String message;

  UpdateTaskSuccessState(this.message);
}

class DeleteTaskLoadingState extends TaskOperationsState{}

class DeleteTaskFailureState extends TaskOperationsState{
  final String error;

  DeleteTaskFailureState(this.error);
}

class DeleteTaskSuccessState extends TaskOperationsState{
  final String message;

  DeleteTaskSuccessState(this.message);
}


class SelectImageState extends TaskOperationsState{}

class SelectDueDateState extends TaskOperationsState{}