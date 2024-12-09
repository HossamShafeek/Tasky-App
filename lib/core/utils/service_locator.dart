import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tasky/core/api/api_services_implementation.dart';
import 'package:tasky/core/api/app_interceptors.dart';
import 'package:tasky/features/authentication/data/repository/authentication_repository_implementation.dart';
import 'package:tasky/features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:tasky/features/authentication/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:tasky/features/home/data/repository/home_repository_implementation.dart';
import 'package:tasky/features/home/presentation/cubits/tab_bar_cubit/tab_bar_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:tasky/features/profile/data/repositry/profile_repository_implementation.dart';
import 'package:tasky/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  //App Interceptors
  getIt.registerSingleton<AppInterceptors>(AppInterceptors(Dio()));
  // Api Service
  getIt.registerSingleton<ApiServicesImplementation>(
      ApiServicesImplementation(getIt.get<AppInterceptors>()));
  //Auth Repo ( Login Cubit - Register Cubit )
  getIt.registerSingleton<AuthenticationRepositoryImplementation>(
      AuthenticationRepositoryImplementation(
          getIt.get<ApiServicesImplementation>()));
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt.get<AuthenticationRepositoryImplementation>()),
  );
  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt.get<AuthenticationRepositoryImplementation>()),
  );
  // TabBar Cubit
  getIt.registerFactory<TabBarCubit>(() => TabBarCubit(),);
  // Home Repo ( Tasks Cubit - Task Operations Cubit )
   getIt.registerSingleton<HomeRepositoryImplementation>(
       HomeRepositoryImplementation(getIt.get<ApiServicesImplementation>()));
   getIt.registerFactory<TasksCubit>(
           () => TasksCubit(getIt.get<HomeRepositoryImplementation>()));
   getIt.registerFactory<TaskOperationsCubit>(
           () => TaskOperationsCubit(getIt.get<HomeRepositoryImplementation>()));
  //Profile Repo ( Profile Cubit )
  getIt.registerSingleton<ProfileRepositoryImplementation>(
      ProfileRepositoryImplementation(getIt.get<ApiServicesImplementation>()));
  getIt.registerFactory(
    () => ProfileCubit(getIt.get<ProfileRepositoryImplementation>()),
  );

}
