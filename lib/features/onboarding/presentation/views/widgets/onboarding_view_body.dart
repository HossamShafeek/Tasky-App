import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/config/local/cache_helper.dart';
import 'package:tasky/config/routes/app_routes.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/CustomElevatedButtonWithIcon.dart';
import 'package:tasky/core/widgets/background_image.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: AppConstants.size70h),
        child: Column(
          children: [
            const BackgroundImage(),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
              child: Column(
                children: [
                  Text(
                    AppStrings.onBoardingTitle,
                    style: AppStyles.styleBold24Black,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: AppConstants.size15h,
                      bottom: AppConstants.size30h,
                    ),
                    child: Text(
                      AppStrings.onBoardingSubtitle,
                      style: AppStyles.styleRegular14Grey,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CustomElevatedButtonWithIcon(
                    onPressed: () {
                      CacheHelper.setData(key: 'onBoarding', value: 'true');
                      Navigator.pushReplacementNamed(context, Routes.loginView);
                    },
                    title: AppStrings.letIsStart,
                    icon: RotatedBox(
                      quarterTurns: 2,
                      child: SvgPicture.asset(
                        AppAssets.arrowLeft,
                        colorFilter: const ColorFilter.mode(
                          AppColors.white, // Use the state color for tinting
                          BlendMode.srcIn,
                        ),
                        height: AppConstants.iconSize24,
                        width: AppConstants.iconSize24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
