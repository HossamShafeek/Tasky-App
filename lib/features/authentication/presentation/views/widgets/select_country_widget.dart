import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/config/icons/icons_broken.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/app_styles.dart';

class SelectCountryWidget extends StatelessWidget {
  const SelectCountryWidget(
      {super.key, required this.onSelect, required this.country});

  final void Function(Country country) onSelect;
  final Country country;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showCountryPicker(
          showPhoneCode: true,
          context: context,
          onSelect: onSelect,
          countryListTheme: CountryListThemeData(
            bottomSheetHeight: 500.h,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppConstants.radius30r),
              topRight: Radius.circular(AppConstants.radius30r),
            ),
            inputDecoration: InputDecoration(
              hintText: AppStrings.search,
              prefixIcon: Icon(IconBroken.Search,size: AppConstants.iconSize18,),
              filled: true,
              isDense: true,
              hintStyle: AppStyles.styleRegular14Grey,
              fillColor: AppColors.grey50,
              border: AppConstants.enabledBorder,
              focusedBorder: AppConstants.focusedBorder,
            ),
          ),
        );
      },
      child: Container(
        width: 60.h,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: AppConstants.size5h),
        child: Text(
          '${country.flagEmoji}'
          ' + '
          '${country.phoneCode}',
          style: AppStyles.styleBold16Black,
        ),
      ),
    );
  }
}
