import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        AppAssets.arrowLeft,
        height: MediaQuery.sizeOf(context).width>780?AppConstants.iconSize24:AppConstants.iconSize28,
        colorFilter: const ColorFilter.mode(
          AppColors.white, // Use the state color for tinting
          BlendMode.srcIn,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
