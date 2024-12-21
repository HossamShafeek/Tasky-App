import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/authentication/domain/entities/authentication_entity.dart';
import 'package:tasky/features/authentication/domain/repository/authentication_repository.dart';
import 'package:tasky/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:tasky/features/authentication/presentation/cubits/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUseCase}) : super(LoginInitialState());

  final LoginUseCase loginUseCase;

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

  AuthenticationEntity? loginEntity;

  Future<void> login() async {
    emit(LoginLoadingState());
    Either<Failure, AuthenticationEntity> result;
    result = await loginUseCase.call(
      LoginParams(
          phone: '${phoneNumber.countryCode}${phoneNumber.number}',
      password: passwordController.text,
         ),
    );
    result.fold((failure) {
      emit(LoginFailureState(failure.error));
    }, (loginEntity) {
      this.loginEntity = loginEntity;
      emit(LoginSuccessState(loginEntity));
    });
  }
}
