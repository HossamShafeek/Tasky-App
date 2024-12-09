import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/widgets/logo_text_widget.dart';


class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppConstants.systemUiOverlayStyleLight,
      child: SafeArea(
        child: Center(
          child: LogoTextWidget(),
        ),
      ),
    );
  }
}
