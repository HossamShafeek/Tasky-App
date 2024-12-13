import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppConstants {
  static String accessToken = '';
  static String refreshToken = '';
  static const String path = 'assets/images/';
  static final double defaultPadding = 20.h;
  static final double defaultPaddingW = 20.w;
  static final double size15h = 15.h;
  static final double size22h = 22.h;
  static final double size50h = 50.h;
  static final double size70h = 70.h;
  static final double size30h = 30.h;
  static final double size35h = 35.h;
  static final double size25h = 25.h;
  static final double size45h = 45.h;
  static final double size40h = 40.h;
  static final double size10h = 10.h;
  static final double size20h = 20.h;
  static final double size10w = 10.w;
  static final double size8w = 8.w;
  static final double size15w = 15.w;
  static final double size200w = 200.w;
  static final double size5w = 5.w;
  static final double size3w = 3.w;
  static final double size8h = 8.h;
  static final double size2h = 2.h;
  static final double size5h = 5.h;
  static final double size3h = 3.h;
  static final double size4h = 4.h;
  static final double radius15r = 15.r;
  static final double radius8r = 8.r;
  static final double radius6r = 6.r;
  static final double radius10r = 10.r;
  static final double radius5r = 5.r;
  static final double radius30r = 30.r;
  static final double radius20r = 20.r;
  static final double radius25r = 25.r;
  static final double radius24r = 24.r;
  static final double radius28r = 28.r;
  static final double iconSize24 = 24.sp;
  static final double iconSize23 = 23.sp;
  static final double iconSize18 = 18.sp;
  static final double iconSize19 = 19.sp;
  static final double iconSize16 = 16.sp;
  static final double iconSize14 = 14.sp;
  static final double iconSize28 = 28.sp;
  static final double iconSize33 = 33.sp;
  static final double iconSize22 = 22.sp;
  static final double iconSize20 = 20.sp;

  static final OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius8r),
    borderSide: BorderSide(
      width: 1.1.w,
      color: AppColors.primary,
    ),
  );

  static final OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius8r),
    borderSide: BorderSide(
      width: 1.1.w,
      color: AppColors.grey300,
    ),
  );

  static const SystemUiOverlayStyle systemUiOverlayStyleLight =
      SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarColor: AppColors.transparent,
  );
  static const SystemUiOverlayStyle systemUiOverlayStyleDark =
      SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );
}
