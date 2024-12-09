import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/config/icons/icons_broken.dart';
import 'package:tasky/config/routes/app_routes.dart';
import 'package:tasky/core/functions/logout.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/widgets/logo_text_widget.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:tasky/features/home/presentation/views/widgets/floating_action_buttons_section.dart';
import 'package:tasky/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    TasksCubit.get(context).getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90.w,
        leading: Padding(
          padding: EdgeInsets.only(left: AppConstants.defaultPadding),
          child: const LogoTextWidget(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.profileView);
            },
            icon: Icon(
              IconBroken.Profile,
              size: MediaQuery.sizeOf(context).width > 780
                  ? AppConstants.iconSize18
                  : AppConstants.iconSize22,
            ),
          ),
          IconButton(
            onPressed: () {
              logout(context: context);
            },
            icon: Icon(
              IconBroken.Logout,
              size: MediaQuery.sizeOf(context).width > 780
                  ? AppConstants.iconSize18
                  : AppConstants.iconSize22,
            ),
          ),
        ],
      ),
      body: const HomeViewBody(),
      floatingActionButton: const FloatingActionButtonsSection(),
    );
  }
}



