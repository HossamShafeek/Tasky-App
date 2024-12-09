import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/shimmer/shimmer_profile_view.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/widgets/custom_back_button.dart';
import 'package:tasky/core/widgets/custom_error_widget.dart';
import 'package:tasky/core/widgets/no_internet_widget.dart';
import 'package:tasky/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:tasky/features/profile/presentation/cubits/profile_cubit/profile_state.dart';
import 'package:tasky/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    ProfileCubit.get(context).getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text(AppStrings.profile),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is GetUserProfileSuccessState) {
            return ProfileViewBody(profileModel: state.profileModel);
          } else if (state is GetUserProfileFailureState) {
            if(state.error.contains('internet connection')){
              return NoInternetWidget(onPressed: (){
                ProfileCubit.get(context).getUserProfile();
              });
            }else{
              return CustomErrorWidget(error: state.error);
            }
          } else {
            return const ShimmerProfileView();
          }
        },
      ),
    );
  }
}
