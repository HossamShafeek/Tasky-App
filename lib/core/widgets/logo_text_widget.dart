import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/utils/app_assets.dart';


class LogoTextWidget extends StatelessWidget {
  const LogoTextWidget({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
     return SvgPicture.asset(
    AppAssets.logo,
    width: size??125.h,
  );
  }
}
