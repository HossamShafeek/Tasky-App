import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_styles.dart';

class CustomElevatedButtonWithIcon extends StatelessWidget {
  const CustomElevatedButtonWithIcon({
    super.key,
    required this.onPressed,
    required this.title,
    required this.icon,
    this.titleColor,
    this.backgroundColors,
  });

  final VoidCallback? onPressed;
  final String title;
  final Widget icon;
  final Color? titleColor, backgroundColors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
          WidgetStateProperty.all(backgroundColors ?? AppColors.primary),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.radius10r),
            ),
          ),
          elevation: WidgetStateProperty.all(0),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppStyles.styleRegular18White.copyWith(
                color: titleColor,
              ),
            ),
            Gap(AppConstants.size5w),
            icon,
          ],
        ),
      ),
    );
  }
}
