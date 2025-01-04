import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tasky/config/local/cache_helper.dart';
import 'package:tasky/config/routes/app_routes.dart';
import 'package:tasky/core/functions/show_snack_bar.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/widgets/background_image.dart';
import 'package:tasky/core/widgets/custom_elevated_button.dart';
import 'package:tasky/core/widgets/title_and_text_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky/features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:tasky/features/authentication/presentation/cubits/login_cubit/login_state.dart';
import 'package:tasky/features/authentication/presentation/widgets/login_texts_fields_section.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailureState) {
          showErrorSnackBar(context: context, message: state.error);
        } else if (state is LoginSuccessState) {
          CacheHelper.setData(
              key: 'access_token', value: state.loginEntity.accessToken);
          CacheHelper.setData(
              key: 'refresh_token', value: state.loginEntity.refreshToken);
          AppConstants.accessToken = state.loginEntity.accessToken;
          AppConstants.refreshToken = state.loginEntity.refreshToken;
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.homeView, (route) => false);
          showSuccessSnackBar(
              context: context, message: 'logged in successfully!');
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginLoadingState,
          color: Colors.white,
          opacity: 0.5,
          progressIndicator: const CircularProgressIndicator(),
          child: SafeArea(
            child: Form(
              key: LoginCubit.get(context).formKey,
              child: Column(
                children: [
                  const BackgroundImage(flex: 4,),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(

                     physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppConstants.defaultPadding),
                        child: Column(
                          children: [
                            const LoginTextsFieldsSection(),
                            CustomElevatedButton(
                              onPressed: () {
                                if (LoginCubit.get(context)
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  if(LoginCubit.get(context).phoneNumber.number.isNotEmpty){
                                    LoginCubit.get(context).login();
                                  }else{
                                    showErrorSnackBar(context: context, message: AppStrings.pleaseEnterYourPhone);
                                  }
                                }
                              },
                              title: AppStrings.signIn,
                            ),
                            TitleAndTextButton(
                              title: AppStrings.signInSubtitle,
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.registerView);
                              },
                              titleForButton: AppStrings.signIn,
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
