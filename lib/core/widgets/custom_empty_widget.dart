import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_styles.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.paddingForTop,
    this.paddingForBottom, this.imageSize,
  });

  final String imagePath;
  final String title;
  final String subtitle;
  final double? paddingForTop;
  final double? paddingForBottom;
  final double? imageSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppConstants.defaultPadding,
        right: AppConstants.defaultPadding,
        bottom: paddingForTop ?? 50.h,
        top: paddingForTop ?? 0,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(imagePath, height: imageSize??240.h),
            Gap(AppConstants.size20h),
            Text(
              title,
              style: AppStyles.styleBold20Primary,
            ),
            Gap(AppConstants.size5h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppStyles.styleRegular18White.copyWith(
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
