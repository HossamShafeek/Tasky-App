import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/config/routes/app_routes.dart';
import 'package:tasky/config/themes/app_theme.dart';
import 'package:tasky/core/utils/app_strings.dart';


class Tasky extends StatelessWidget {
  const Tasky({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: AppStrings.tasky,
          debugShowCheckedModeBanner: false,
          theme: appTheme(),
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}