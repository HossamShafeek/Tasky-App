import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tasky/config/icons/icons_broken.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:tasky/features/authentication/presentation/cubits/login_cubit/login_state.dart';
import 'package:tasky/features/authentication/presentation/views/widgets/select_country_widget.dart';

class LoginTextsFieldsSection extends StatelessWidget {
  const LoginTextsFieldsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.signIn,
              style: AppStyles.styleBold24Black,
              textAlign: TextAlign.center,
            ),
            Gap(AppConstants.size15h),
            CustomTextField(
              textInputType: TextInputType.phone,
              controller: LoginCubit.get(context).phoneController,
              suffixIcon: Icon(
                IconBroken.Call,
                size: MediaQuery.sizeOf(context).width > 780
                    ? AppConstants.iconSize14
                    : AppConstants.iconSize18,
              ),
              prefixIcon: SelectCountryWidget(
                onSelect: (Country country) {
                  LoginCubit.get(context)
                      .changeSelectedCountry(country: country);
                },
                country: LoginCubit.get(context).selectedCountry,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppStrings.pleaseEnterYourPhone;
                }
                return null;
              },
              hintText: AppStrings.enterYourPhone,
            ),
            CustomTextField(
              textInputType: TextInputType.visiblePassword,
              obscureText: LoginCubit.get(context).isShowPassword,
              suffixIcon: InkWell(
                onTap: () {
                  LoginCubit.get(context).changePasswordVisibility();
                },
                child: Icon(
                  LoginCubit.get(context).isShowPassword
                      ? IconBroken.Hide
                      : IconBroken.Show,
                  color: AppColors.grey,
                  size: MediaQuery.sizeOf(context).width > 780
                      ? AppConstants.iconSize14
                      : AppConstants.iconSize18,
                ),
              ),
              controller: LoginCubit.get(context).passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppStrings.pleaseEnterPassword;
                }
                return null;
              },
              hintText: AppStrings.enterPassword,
            ),
          ],
        );
      },
    );
  }
}
