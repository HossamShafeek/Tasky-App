import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tasky/config/icons/icons_broken.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:tasky/features/authentication/presentation/cubits/login_cubit/login_state.dart';
import 'package:tasky/features/authentication/presentation/widgets/select_phone_number_widget.dart';

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
            SelectPhoneNumberWidget(
              onChanged: (PhoneNumber phoneNumber) {
                LoginCubit.get(context).changeSelectedPhoneNumber(phoneNumber: phoneNumber);
              },
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
