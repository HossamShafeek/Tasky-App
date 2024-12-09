import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_styles.dart';

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;
  final int alpha = color.alpha;

  final Map<int, Color> shades = {
    50: Color.fromARGB(alpha, red, green, blue),
    100: Color.fromARGB(alpha, red, green, blue),
    200: Color.fromARGB(alpha, red, green, blue),
    300: Color.fromARGB(alpha, red, green, blue),
    400: Color.fromARGB(alpha, red, green, blue),
    500: Color.fromARGB(alpha, red, green, blue),
    600: Color.fromARGB(alpha, red, green, blue),
    700: Color.fromARGB(alpha, red, green, blue),
    800: Color.fromARGB(alpha, red, green, blue),
    900: Color.fromARGB(alpha, red, green, blue),
  };

  return MaterialColor(color.value, shades);
}


ThemeData appTheme() {
  return ThemeData(
      primarySwatch: getMaterialColor(AppColors.primary),
      useMaterial3: false,
      unselectedWidgetColor: AppColors.grey,
      textTheme: GoogleFonts.montserratTextTheme(),
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: AppBarTheme(
        color: AppColors.primary,
        elevation: 0,
        toolbarHeight: 40.h,
        systemOverlayStyle: AppConstants.systemUiOverlayStyleLight,
        titleTextStyle: AppStyles.styleBold20Primary.copyWith(
          color: AppColors.white,
        ),
        centerTitle: false,
      ),
     );
}
