import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_elevated_button.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppConstants.defaultPadding),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.noInternet, height: 240.h),
            Gap(AppConstants.size20h),
            Text(
              AppStrings.noInternetTitle,
              style: AppStyles.styleBold20Primary,
            ),
            Gap(AppConstants.size5h),
            Text(
              AppStrings.noInternetSubtitle,
              textAlign: TextAlign.center,
              style: AppStyles.styleRegular18White.copyWith(
                color: AppColors.black,
              ),
            ),
            Gap(AppConstants.size20h),
            CustomElevatedButton(
              onPressed: onPressed,
              title: AppStrings.tryAgain,
            ),
          ],
        ),
      ),
    );
  }
}