import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/authentication/data/models/authentication_model.dart';
import 'package:tasky/features/authentication/data/repository/authentication_repository.dart';
import 'package:tasky/features/authentication/presentation/cubits/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authenticationRepository) : super(LoginInitialState());

  final AuthenticationRepository authenticationRepository;

  TextEditingController passwordController = TextEditingController();


  var formKey = GlobalKey<FormState>();

  static LoginCubit get(context) => BlocProvider.of(context);

   PhoneNumber phoneNumber=PhoneNumber(countryISOCode: '', countryCode: '', number: '');

  void changeSelectedPhoneNumber({required PhoneNumber phoneNumber}) {
    this.phoneNumber = phoneNumber;
    emit(LoginChangeSelectedPhoneNumberState());
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
      phone: '${phoneNumber.countryCode}${phoneNumber.number}',
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
