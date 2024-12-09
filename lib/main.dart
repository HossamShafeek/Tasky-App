import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/bloc_observer.dart';
import 'package:tasky/config/local/cache_helper.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/service_locator.dart';
import 'package:tasky/tasky_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]
  );
  await ScreenUtil.ensureScreenSize();
  await CacheHelper.init();
  setupServiceLocator();
  AppConstants.accessToken =await CacheHelper.getData(key: 'access_token') ?? '';
  AppConstants.refreshToken =await CacheHelper.getData(key: 'refresh_token') ?? '';
  Bloc.observer = MyBlocObserver();
  runApp(const Tasky());
}

