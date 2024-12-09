import 'package:flutter/material.dart';
import 'package:tasky/config/local/cache_helper.dart';
import 'package:tasky/config/routes/app_routes.dart';
import 'package:tasky/core/utils/app_constants.dart';

void logout({required BuildContext context})async{
  await CacheHelper.removeData(key: 'access_token');
  await CacheHelper.removeData(key: 'refresh_token');
  AppConstants.accessToken='';
  AppConstants.refreshToken='';
  Navigator.pushReplacementNamed(context, Routes.loginView);
}