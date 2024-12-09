import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tasky/config/local/cache_helper.dart';
import 'package:tasky/config/routes/app_routes.dart';
import 'package:tasky/core/functions/show_snack_bar.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky/core/widgets/background_image.dart';
import 'package:tasky/core/widgets/custom_elevated_button.dart';
import 'package:tasky/core/widgets/title_and_text_button.dart';
import 'package:tasky/features/authentication/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:tasky/features/authentication/presentation/cubits/register_cubit/register_state.dart';
import 'package:tasky/features/authentication/presentation/views/widgets/register_texts_fields_section.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          CacheHelper.setData(key: 'access_token', value: state.registerModel.accessToken);
          CacheHelper.setData(key: 'refresh_token', value: state.registerModel.refreshToken);
          AppConstants.accessToken = state.registerModel.accessToken;
          AppConstants.refreshToken = state.registerModel.refreshToken;
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.homeView, (route) => false);
          showSuccessSnackBar(
              context: context, message: 'Logged in successfully!');
        } else if (state is RegisterFailureState) {
          showErrorSnackBar(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is RegisterLoadingState,
          color: Colors.white,
          opacity: 0.5,
          progressIndicator: const CircularProgressIndicator(),
          child: SafeArea(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BackgroundImage(flex: 1,),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
                      child: SingleChildScrollView(
                       physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            const RegisterTextsFieldsSection(),
                            CustomElevatedButton(
                              onPressed: () {
                                if (RegisterCubit.get(context)
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  RegisterCubit.get(context).register();
                                }
                              },
                              title:
                              AppStrings.signIn,
                            ),
                            TitleAndTextButton(
                              title: AppStrings.signUpSubtitle,
                              onPressed: () {
                                  Navigator.pop(context);
                              },
                              titleForButton: AppStrings.signUp,
                            ),
                            Gap(AppConstants.size20h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
