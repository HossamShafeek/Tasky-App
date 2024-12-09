import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.validator,
    this.suffixIcon,
    required this.hintText,
    this.maxLength,
    this.textInputType,
    this.obscureText = false,
    this.prefixIcon,
    this.paddingForTop,
    this.paddingForBottom,
    this.maxLines,
    this.readOnly = false,
    this.onTapOutsideUnFocus = true,
    this.onTap,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String hintText;
  final int? maxLength;
  final TextInputType? textInputType;
  final bool obscureText;
  final double? paddingForTop;
  final double? paddingForBottom;
  final int? maxLines;
  final bool? onTapOutsideUnFocus;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: paddingForBottom ?? AppConstants.size15h,
          ),
          child: TextFormField(
            readOnly: readOnly,
            onTapOutside: (value) {
              // if (onTapOutsideUnFocus!) {
              //   FocusScope.of(context).unfocus();
              // }
            },
            style: AppStyles.styleRegular16Black,
            maxLines: maxLines ?? 1,
            controller: controller,
            keyboardType: textInputType,
            maxLength: maxLength,
            obscureText: obscureText,
            validator: validator,
            onTap: onTap,
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              filled: true,
              isDense: true,
              hintStyle: AppStyles.styleRegular14Grey,
              fillColor: AppColors.grey50,
              border: AppConstants.enabledBorder,
              focusedBorder: AppConstants.focusedBorder,
            ),
          ),
        ),
      ],
    );
  }
}
