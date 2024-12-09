import 'package:country_picker/country_picker.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/authentication/data/models/authentication_model.dart';
import 'package:tasky/features/authentication/data/repository/authentication_repository.dart';
import 'package:tasky/features/authentication/presentation/cubits/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authenticationRepository) : super(LoginInitialState());

  final AuthenticationRepository authenticationRepository;

  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  static LoginCubit get(context) => BlocProvider.of(context);

  Country selectedCountry = Country(
    phoneCode: '20',
    countryCode: 'EG',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Egypt',
    example: 'Egypt',
    displayName: 'Egypt',
    displayNameNoCountryCode: 'EG',
    e164Key: '20-EG-0',
  );

  void changeSelectedCountry({required Country country}) {
    selectedCountry = country;
    emit(LoginChangeSelectedCountryState());
  }

  bool isShowPassword = true;

  void changePasswordVisibility() {
    isShowPassword = !isShowPassword;
    emit(LoginChangePasswordVisibilityState());
  }

  AuthenticationModel? loginModel;

  Future<void> login() async {
    emit(LoginLoadingState());
    Either<Failure, AuthenticationModel> result;
    result = await authenticationRepository.login(
      phone: '+${selectedCountry.phoneCode}${phoneController.text}',
      password: passwordController.text,
    );
    result.fold((failure) {
      emit(LoginFailureState(failure.error));
    }, (loginModel) {
      this.loginModel = loginModel;
      emit(LoginSuccessState(loginModel));
    });
  }
}
