import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_styles.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    this.validator,
    this.value,
    required this.hintText,
    this.paddingForTop,
    this.paddingForBottom,
    required this.messageForValidate,
    required this.items,
    required this.onChange, this.icon, this.backgroundColor, this.border, this.focusedBorder,
  });

  final String? Function(String?)? validator;
  final String hintText;
  final String messageForValidate;
  final double? paddingForTop;
  final dynamic value;
  final double? paddingForBottom;
  final List<DropdownMenuItem> items;
  final Function(dynamic value) onChange;
  final Widget? icon;
  final Color? backgroundColor;
  final InputBorder? border ;
  final InputBorder? focusedBorder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: paddingForBottom ?? AppConstants.size15h,
      ),
      child: DropdownButtonFormField(
        value: value,
        itemHeight: AppConstants.size50h,
        iconSize: MediaQuery.sizeOf(context).width > 780
            ? AppConstants.iconSize16
            : AppConstants.iconSize24,
        validator: (value) => value == null ? messageForValidate : null,
        style: AppStyles.styleRegular16Black,
        decoration: InputDecoration(
          fillColor: backgroundColor??AppColors.white,
          filled: true,
          isDense: MediaQuery.sizeOf(context).width > 780 ? false : true,
          hintStyle: AppStyles.styleRegular14Grey,
          border: border?? AppConstants.enabledBorder,
          focusedBorder: focusedBorder??AppConstants.enabledBorder,
        ),
        isExpanded: true,
        borderRadius: BorderRadius.circular(AppConstants.radius8r),
        hint: Text(
          hintText,
          style: AppStyles.styleRegular14Grey,
        ),
        items: items,
        onChanged: onChange,
        icon: icon??Icon(
          Icons.keyboard_arrow_down_rounded,
          size: MediaQuery.sizeOf(context).width > 780
              ? AppConstants.iconSize24
              : AppConstants.iconSize28,
        ),
      ),
    );
  }
}
