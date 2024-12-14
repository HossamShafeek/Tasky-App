import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/authentication/data/models/authentication_model.dart';
import 'package:tasky/features/authentication/data/repository/authentication_repository.dart';
import 'package:tasky/features/authentication/presentation/cubits/register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authenticationRepository) : super(RegisterInitialState());

  final AuthenticationRepository authenticationRepository;

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

  AuthenticationModel? registerModel;

  Future<void> register() async {
    emit(RegisterLoadingState());
    Either<Failure, AuthenticationModel> result;
    result = await authenticationRepository.register(
      fullName: fullNameController.text,
      phone: '${phoneNumber.countryCode}${phoneNumber.number}',
      password: passwordController.text,
      address: addressController.text,
      experienceYears: double.parse(experienceYearsController.text),
      experienceLevel: experienceLevel,
    );
    result.fold((failure) {
      emit(RegisterFailureState(failure.error));
    }, (registerModel) {
      this.registerModel = registerModel;
      emit(RegisterSuccessState(registerModel));
    });
  }
}
