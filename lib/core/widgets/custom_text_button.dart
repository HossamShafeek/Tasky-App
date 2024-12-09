import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.title, this.textStyle,
  });

  final void Function()? onPressed;
  final String title;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: textStyle??AppStyles.styleRegular14Grey.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }
}
