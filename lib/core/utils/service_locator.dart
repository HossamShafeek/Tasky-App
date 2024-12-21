import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tasky/core/api/api_services_implementation.dart';
import 'package:tasky/core/api/app_interceptors.dart';
import 'package:tasky/features/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:tasky/features/authentication/data/repository/authentication_repository_implementation.dart';
import 'package:tasky/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:tasky/features/authentication/domain/use_cases/register_use_case.dart';
import 'package:tasky/features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:tasky/features/authentication/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:tasky/features/home/data/date_source/home_remote_data_source.dart';
import 'package:tasky/features/home/data/repository/home_repository_implementation.dart';
import 'package:tasky/features/home/domain/use_cases/add_task_use_case.dart';
import 'package:tasky/features/home/domain/use_cases/delete_task_use_case.dart';
import 'package:tasky/features/home/domain/use_cases/get_task_by_id_use_case.dart';
import 'package:tasky/features/home/domain/use_cases/get_tasks_use_case.dart';
import 'package:tasky/features/home/domain/use_cases/update_task_use_case.dart';
import 'package:tasky/features/home/domain/use_cases/upload_image_use_case.dart';
import 'package:tasky/features/home/presentation/cubits/tab_bar_cubit/tab_bar_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:tasky/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:tasky/features/profile/data/repository/profile_repository_implementation.dart';
import 'package:tasky/features/profile/domain/use_cases/get_user_profile_use_case.dart';
import 'package:tasky/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  //! App Interceptors
  getIt.registerSingleton<AppInterceptors>(AppInterceptors(Dio()));
  //! Api Service
  getIt.registerSingleton<ApiServicesImplementation>(
      ApiServicesImplementation(getIt.get<AppInterceptors>()));
  //! Auth Repo ( Login Cubit - Register Cubit )
  getIt.registerSingleton<AuthenticationRepositoryImplementation>(
      AuthenticationRepositoryImplementation(
         authenticationRemoteDataSource: AuthenticationRemoteDataSourceImplementation(apiServices:  getIt.get<ApiServicesImplementation>(),)));
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(loginUseCase: LoginUseCase(authenticationRepository: getIt.get<AuthenticationRepositoryImplementation>())),
  );
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(registerUseCase: RegisterUseCase(authenticationRepository: getIt.get<AuthenticationRepositoryImplementation>())),
  );
  //! TabBar Cubit
  getIt.registerFactory<TabBarCubit>(() => TabBarCubit(),);
  //! Home Repo ( Tasks Cubit - Task Operations Cubit )
   getIt.registerSingleton<HomeRepositoryImplementation>(
       HomeRepositoryImplementation(homeRemoteDataSource: HomeRemoteDataSourceImplementation(apiServices: getIt.get<ApiServicesImplementation>(),),));
   getIt.registerFactory<TasksCubit>(
           () => TasksCubit(tasksCubitParams: TasksCubitParams(
            getTasksUseCase: GetTasksUseCase(homeRepository: getIt.get<HomeRepositoryImplementation>()),
             getTaskByIdUseCase: GetTaskByIdUseCase(homeRepository: getIt.get<HomeRepositoryImplementation>()),
             ),),);
   getIt.registerFactory<TaskOperationsCubit>(
           () => TaskOperationsCubit(taskOperationsCubitParams: TaskOperationsCubitParams(

addTaskUseCase: AddTaskUseCase(homeRepository: getIt.get<HomeRepositoryImplementation>()),
deleteTaskUseCase: DeleteTaskUseCase(homeRepository: getIt.get<HomeRepositoryImplementation>()),
updateTaskUseCase: UpdateTaskUseCase(homeRepository: getIt.get<HomeRepositoryImplementation>()),
uploadImageUseCase: UploadImageUseCase(homeRepository: getIt.get<HomeRepositoryImplementation>()),

           ),),);
  //! Profile Repo ( Profile Cubit )
  getIt.registerSingleton<ProfileRepositoryImplementation>(
      ProfileRepositoryImplementation(profileRemoteDataSource: ProfileRemoteDataSourceImplementation(apiServices: getIt.get<ApiServicesImplementation>(),),),);
  getIt.registerFactory(
    () => ProfileCubit(fetchProfileDataUseCase: GetUserProfileUseCase(profileRepository: getIt.get<ProfileRepositoryImplementation>())),
  );

}
