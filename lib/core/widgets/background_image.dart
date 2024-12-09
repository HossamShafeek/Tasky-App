import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_assets.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key, this.flex});


 final int? flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex??1,
      child: Image.asset(
        AppAssets.backgroundImage,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}
