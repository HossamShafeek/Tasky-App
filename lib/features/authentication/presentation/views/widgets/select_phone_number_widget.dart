import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/app_styles.dart';

class SelectPhoneNumberWidget extends StatelessWidget {
  const SelectPhoneNumberWidget({
    super.key,
    required this.onChanged,
  });

  final Function(PhoneNumber phoneNumber) onChanged;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: IntlPhoneField(
        style: AppStyles.styleRegular16Black,
        decoration: InputDecoration(
          border: AppConstants.enabledBorder,
          focusedBorder: AppConstants.focusedBorder,
          fillColor: AppColors.white,
          filled: true,
          isDense: true,
          hintText: AppStrings.enterYourPhone,
          hintStyle: AppStyles.styleRegular14Grey,
        ),
        initialCountryCode: 'EG',
        onChanged: onChanged,
      ),
    );
  }
}
