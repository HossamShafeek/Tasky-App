import 'package:flutter/material.dart';
import 'package:tasky/config/local/cache_helper.dart';
import 'package:tasky/config/routes/app_routes.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/features/splash/presentation/views/widgets/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    navigateToOnBoardingView();
    super.initState();
  }

  void navigateToOnBoardingView() {
    Future.delayed(const Duration(seconds: 2)).then((value) async{
      if (await CacheHelper.getData(key: 'onBoarding')=='true' ) {
        if (AppConstants.accessToken.isNotEmpty) {
          return Navigator.pushReplacementNamed(context, Routes.homeView);
        } else {
          return Navigator.pushReplacementNamed(context, Routes.loginView);
        }
      } else {
        return Navigator.pushReplacementNamed(context, Routes.onBoardingView);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      resizeToAvoidBottomInset: false,
      body: SplashViewBody(),
    );
  }
}
