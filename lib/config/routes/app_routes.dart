import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/animations/page_fade_transition.dart';
import 'package:tasky/core/animations/page_slide_transition.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/service_locator.dart';
import 'package:tasky/features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:tasky/features/authentication/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:tasky/features/authentication/presentation/views/login_view.dart';
import 'package:tasky/features/authentication/presentation/views/register_view.dart';
import 'package:tasky/features/home/data/models/task_model/task_model.dart';
import 'package:tasky/features/home/presentation/cubits/tab_bar_cubit/tab_bar_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/task_operations_cubit/task_operations_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:tasky/features/home/presentation/views/home_view.dart';
import 'package:tasky/features/home/presentation/views/scan_view.dart';
import 'package:tasky/features/home/presentation/views/task_details_view.dart';
import 'package:tasky/features/home/presentation/views/add_task_view.dart';
import 'package:tasky/features/home/presentation/views/update_task_view.dart';
import 'package:tasky/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:tasky/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:tasky/features/profile/presentation/views/profile_view.dart';
import 'package:tasky/features/splash/presentation/views/splash_view.dart';

class Routes {
  static const String slashView = '/';
  static const String loginView = '/login_view';
  static const String registerView = '/register_view';
  static const String homeView = '/home_view';
  static const String onBoardingView = '/onBoarding_view';
  static const String profileView = '/profile_view';
  static const String taskDetailsView = '/task_details_view';
  static const String scanView = '/scan_view';
  static const String addTaskView = '/add_task_view';
  static const String updateTaskView = '/update_task_view';
}

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic>? navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  static void goBack() {
    return navigatorKey.currentState?.pop();
  }

  static Future<dynamic>? replaceWith(String routeName, {Object? arguments}) {
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.slashView:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
        );
      case Routes.loginView:
        return PageSlideTransition(
          direction: AxisDirection.left,
          page: BlocProvider(
              create: (context) => getIt.get<LoginCubit>(),
              child: const LoginView()),
        );
      case Routes.registerView:
        return PageSlideTransition(
          direction: AxisDirection.left,
          page: BlocProvider(
              create: (context) => getIt.get<RegisterCubit>(),
              child: const RegisterView()),
        );
      case Routes.onBoardingView:
        return PageFadeTransition(
          page: const OnBoardingView(),
        );
      case Routes.homeView:
        return PageFadeTransition(
          page: MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => getIt.get<TabBarCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt.get<TasksCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt.get<TaskOperationsCubit>(),
            ),
          ], child: const HomeView()),
        );

      case Routes.profileView:
        return PageSlideTransition(
          direction: AxisDirection.left,
          page: BlocProvider(
              create: (context) => getIt.get<ProfileCubit>(),
              child: const ProfileView()),
        );
      case Routes.taskDetailsView:
        TaskModel taskModel = settings.arguments as TaskModel;
        return PageSlideTransition(
          direction: AxisDirection.left,
          page: BlocProvider(
              create: (context) => getIt.get<TaskOperationsCubit>(),
              child: TaskDetailsView(taskModel: taskModel)),
        );
      case Routes.scanView:
        final BuildContext contextForBloc = settings.arguments as BuildContext;
        return PageSlideTransition(
          direction: AxisDirection.left,
          page: BlocProvider.value(
            value: contextForBloc.read<TasksCubit>(),
            child: ScanView(
              contextForBloc: contextForBloc,
            ),
          ),
        );
        case Routes.addTaskView:
        return PageSlideTransition(
          direction: AxisDirection.left,
          page: BlocProvider(
            create:  (context) => getIt.get<TaskOperationsCubit>(),
            child: const AddTaskView(),
          ),
        );
        case Routes.updateTaskView:
          final TaskModel taskModel =settings.arguments as TaskModel;
        return PageSlideTransition(
          direction: AxisDirection.left,
          page: BlocProvider(
            create:  (context) => getIt.get<TaskOperationsCubit>(),
            child:  UpdateTaskView(taskModel: taskModel),
          ),
        );
    }
    return undefinedRoute();
  }

  static Route undefinedRoute() {
    return MaterialPageRoute(
      builder: ((context) => const Scaffold(
            body: Center(
              child: Text(AppStrings.noRouteFound),
            ),
          )),
    );
  }
}
