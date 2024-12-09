import 'package:flutter/material.dart';
import 'package:tasky/core/animations/scale_transition_animation.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_styles.dart';

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppConstants.size10h),
      child: ListTile(
        tileColor: AppColors.grey200,
        title: ScaleTransitionAnimation(
            duration: const Duration(milliseconds: 800),
            child: Text(
          title,
          style: AppStyles.styleMedium12Black.copyWith(color: AppColors.grey),
        )),
        subtitle: ScaleTransitionAnimation(
          duration: const Duration(milliseconds: 600),
          child: Text(
            subtitle,
            style: AppStyles.styleBold18Grey600,
          ),
        ),
        trailing: ScaleTransitionAnimation(
            duration: const Duration(milliseconds: 600),
            child: trailing ?? const SizedBox.shrink()),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radius10r)),
      ),
    );
  }
}
