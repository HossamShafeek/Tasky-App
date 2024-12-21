import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/authentication/domain/entities/authentication_entity.dart';
import 'package:tasky/features/authentication/domain/repository/authentication_repository.dart';
import 'package:tasky/features/authentication/domain/use_cases/register_use_case.dart';
import 'package:tasky/features/authentication/presentation/cubits/register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.registerUseCase}) : super(RegisterInitialState());

  final RegisterUseCase registerUseCase;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController experienceYearsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String experienceLevel = '';

  var formKey = GlobalKey<FormState>();

  static RegisterCubit get(context) => BlocProvider.of(context);

  PhoneNumber phoneNumber=PhoneNumber(countryISOCode: '', countryCode: '', number: '');

  void changeSelectedPhoneNumber({required PhoneNumber phoneNumber}) {
    this.phoneNumber = phoneNumber;
    emit(RegisterChangeSelectedPhoneNumberState());
  }

  bool isShowPassword = true;

  void changePasswordVisibility() {
    isShowPassword = !isShowPassword;
    emit(RegisterChangePasswordVisibilityState());
  }

  void chooseExperienceLevel({required String experienceLevel}) {
 this.experienceLevel=experienceLevel;
    emit(RegisterSelectExperienceLevelState());
  }

  AuthenticationEntity? registerEntity;

  Future<void> register() async {
    emit(RegisterLoadingState());
    Either<Failure, AuthenticationEntity> result;
    result = await registerUseCase.call(
     RegisterParams(
       fullName: fullNameController.text,
      phone: '${phoneNumber.countryCode}${phoneNumber.number}',
      password: passwordController.text,
      address: addressController.text,
      experienceYears: double.parse(experienceYearsController.text),
      experienceLevel: experienceLevel,
     ),
    );
    result.fold((failure) {
      emit(RegisterFailureState(failure.error));
    }, (registerEntity) {
      this.registerEntity = registerEntity;
      emit(RegisterSuccessState(registerEntity));
    });
  }
}
