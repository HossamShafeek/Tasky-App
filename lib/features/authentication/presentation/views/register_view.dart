import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/features/authentication/presentation/widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AnnotatedRegion(
        value: AppConstants.systemUiOverlayStyleDark,
        child: RegisterViewBody(),
      ),
    );
  }
}
