import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/core/widgets/custom_dropdown.dart';
import 'package:tasky/config/icons/icons_broken.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/widgets/custom_text_field.dart';
import 'package:tasky/features/authentication/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:tasky/features/authentication/presentation/cubits/register_cubit/register_state.dart';
import 'package:tasky/features/authentication/presentation/views/widgets/select_country_widget.dart';

class RegisterTextsFieldsSection extends StatelessWidget {
  const RegisterTextsFieldsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Form(
          key: RegisterCubit.get(context).formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.signUp,
                style: AppStyles.styleBold24Black,
                textAlign: TextAlign.center,
              ),
              Gap(AppConstants.size15h),
              CustomTextField(
                textInputType: TextInputType.name,
                controller: RegisterCubit.get(context).fullNameController,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return AppStrings.pleaseEnterFullName;
                  }
                  return null;
                },
                hintText: AppStrings.enterFullName,
              ),
              CustomTextField(
                textInputType: TextInputType.phone,
                controller: RegisterCubit.get(context).phoneController,
                suffixIcon: Icon(
                  IconBroken.Call,
                  size: MediaQuery.sizeOf(context).width > 780
                      ? AppConstants.iconSize14
                      : AppConstants.iconSize18,
                ),
                prefixIcon: SelectCountryWidget(
                  onSelect: (Country country) {
                    RegisterCubit.get(context)
                        .changeSelectedCountry(country: country);
                  },
                  country: RegisterCubit.get(context).selectedCountry,
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
                textInputType: TextInputType.number,
                controller:
                    RegisterCubit.get(context).experienceYearsController,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return AppStrings.pleaseExperienceYears;
                  }
                  return null;
                },
                hintText: AppStrings.enterExperienceYears,
              ),
              CustomDropdown(
                hintText: AppStrings.chooseExperienceLevel,
                messageForValidate: AppStrings.pleaseChooseExperienceLevel,
                items: ['fresh', 'junior', 'midLevel', 'senior']
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChange: (value) {
                  RegisterCubit.get(context).experienceLevel = value;
                },
              ),
              CustomTextField(
                textInputType: TextInputType.text,
                controller: RegisterCubit.get(context).addressController,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return AppStrings.pleaseEnterAddress;
                  }
                  return null;
                },
                hintText: AppStrings.enterAddress,
              ),
              CustomTextField(
                textInputType: TextInputType.visiblePassword,
                controller: RegisterCubit.get(context).passwordController,
                obscureText: RegisterCubit.get(context).isShowPassword,
                suffixIcon: InkWell(
                  onTap: () {
                    RegisterCubit.get(context).changePasswordVisibility();
                  },
                  child: Icon(
                    RegisterCubit.get(context).isShowPassword
                        ? IconBroken.Hide
                        : IconBroken.Show,
                    color: AppColors.grey,
                    size: MediaQuery.sizeOf(context).width > 780
                        ? AppConstants.iconSize14
                        : AppConstants.iconSize18,
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return AppStrings.pleaseEnterPassword;
                  } else if (value.length < 8) {
                    return 'Password is too short';
                  }
                  return null;
                },
                hintText: 'Enter your password',
              ),
            ],
          ),
        );
      },
    );
  }
}
