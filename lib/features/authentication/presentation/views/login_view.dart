import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/features/authentication/presentation/widgets/login_view_body.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AnnotatedRegion(
        value: AppConstants.systemUiOverlayStyleDark,
        child: LoginViewBody(),
      ),
    );
  }
}
