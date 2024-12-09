import 'package:flutter/material.dart';
import 'package:tasky/core/shimmer/shimmer_profile_item.dart';
import 'package:tasky/core/utils/app_constants.dart';

class ShimmerProfileView extends StatelessWidget {
  const ShimmerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
     physics: const BouncingScrollPhysics(),
      child: Padding(
        padding:  EdgeInsets.all(AppConstants.defaultPadding),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerProfileItem(),
            ShimmerProfileItem(),
            ShimmerProfileItem(),
            ShimmerProfileItem(),
            ShimmerProfileItem(),
          ],
        ),
      ),
    );
  }
}



