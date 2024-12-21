import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/functions/svae_to_clipboard.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/features/profile/domain/entities/profile_entity.dart';
import 'package:tasky/features/profile/presentation/views/widgets/profile_item_widget.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key, required this.profileEntity});

  final ProfileEntity profileEntity;

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
            subtitle: profileEntity.displayName,
          ),
          ProfileItemWidget(
            title: 'PHONE',
            subtitle: profileEntity.username,
            trailing: IconButton(
              onPressed: () {
                saveToClipboard(
                  context: context,
                   phone: profileEntity.username,
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
            subtitle: profileEntity.experienceLevel,
          ),
          ProfileItemWidget(
            title: 'Years of experience',
            subtitle: '${profileEntity.experienceYears} Years',
          ),
          ProfileItemWidget(
            title: 'Location',
            subtitle: profileEntity.address,
          ),
        ],
      ),
    );
  }
}
