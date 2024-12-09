import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/functions/svae_coupon_to_clipboard.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/features/profile/data/models/profile_model/profile_model.dart';
import 'package:tasky/features/profile/presentation/views/widgets/profile_item_widget.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key, required this.profileModel});

  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppConstants.defaultPadding),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileItemWidget(
            title: 'NAME',
            subtitle: profileModel.displayName,
          ),
          ProfileItemWidget(
            title: 'PHONE',
            subtitle: profileModel.username,
            trailing: IconButton(
              onPressed: () {
                saveCouponCodeToClipboard(
                  context: context,
                   phone: profileModel.username,
                );
              },
              icon: SvgPicture.asset(
                AppAssets.copy,
                height: MediaQuery.sizeOf(context).width > 780
                    ?AppConstants.iconSize18:AppConstants.iconSize22,
                width: MediaQuery.sizeOf(context).width > 780
                    ?AppConstants.iconSize18:AppConstants.iconSize22,
              ),
            ),
          ),
          ProfileItemWidget(
            title: 'LEVEL',
            subtitle: profileModel.experienceLevel,
          ),
          ProfileItemWidget(
            title: 'Years of experience',
            subtitle: '${profileModel.experienceYears} Years',
          ),
          ProfileItemWidget(
            title: 'Location',
            subtitle: profileModel.address,
          ),
        ],
      ),
    );
  }
}
