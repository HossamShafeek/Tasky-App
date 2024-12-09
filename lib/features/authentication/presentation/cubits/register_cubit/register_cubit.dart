import 'package:country_picker/country_picker.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/authentication/data/models/authentication_model.dart';
import 'package:tasky/features/authentication/data/repository/authentication_repository.dart';
import 'package:tasky/features/authentication/presentation/cubits/register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authenticationRepository) : super(RegisterInitialState());

  final AuthenticationRepository authenticationRepository;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController experienceYearsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String experienceLevel = '';

  var formKey = GlobalKey<FormState>();

  static RegisterCubit get(context) => BlocProvider.of(context);

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
    emit(RegisterChangeSelectedCountryState());
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
      phone: '+${selectedCountry.phoneCode}${phoneController.text}',
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
