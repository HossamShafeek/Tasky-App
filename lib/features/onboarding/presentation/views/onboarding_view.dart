import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/features/onboarding/presentation/views/widgets/onboarding_view_body.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppConstants.systemUiOverlayStyleDark,
        child: OnBoardingViewBody(),
      ),
    );
  }
}
