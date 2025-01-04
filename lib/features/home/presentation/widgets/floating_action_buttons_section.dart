import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:tasky/config/routes/app_routes.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_cubit.dart';

class FloatingActionButtonsSection extends StatelessWidget {
  const FloatingActionButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<TasksCubit>(),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: AppConstants.size35h,
            height: AppConstants.size35h,
            child: FloatingActionButton(
              heroTag: '1',
              onPressed: () {
                Navigator.pushNamed(context, Routes.scanView,arguments: context);
              },
              backgroundColor: AppColors.white,
              child: SvgPicture.asset(
                AppAssets.scan,
                width: MediaQuery.sizeOf(context).width > 780
                    ? AppConstants.iconSize18
                    : AppConstants.iconSize22,
                height: MediaQuery.sizeOf(context).width > 780
                    ? AppConstants.iconSize18
                    : AppConstants.iconSize22,
              ),
            ),
          ),
          Gap(AppConstants.size8h),
          SizedBox(
            width: AppConstants.size45h,
            height: AppConstants.size45h,
            child: FloatingActionButton(
              heroTag: '2',
              onPressed: () {
                Navigator.pushNamed(context, Routes.addTaskView);
              },
              child: Icon(
                Icons.add_rounded,
                size: MediaQuery.sizeOf(context).width > 780
                    ? AppConstants.iconSize24
                    : AppConstants.iconSize28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}