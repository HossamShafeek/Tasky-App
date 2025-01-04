import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/features/home/presentation/cubits/tab_bar_cubit/tab_bar_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/tab_bar_cubit/tab_bar_state.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBarCubit, TabBarState>(
      builder: (context, state) {
        return Expanded(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children:
                      TabBarCubit.get(context).tabs.asMap().entries.map((tab) {
                    return GestureDetector(
                      onTap: (){
                        TabBarCubit.get(context).changeTabBarIndex(tab.key);
                      },
                      child: Container(
                        padding: EdgeInsets.all(AppConstants.size8h),
                        margin: EdgeInsets.only(
                          top: AppConstants.size10h,
                          bottom: AppConstants.size5h,
                          right: AppConstants.size8w,
                        ),
                        decoration: BoxDecoration(
                          color: tab.key==TabBarCubit.get(context).index?AppColors.primary:AppColors.primaryWithOpacity,
                          borderRadius: BorderRadius.circular(
                            AppConstants.radius25r,
                          ),
                        ),
                        child: Text(
                          tab.value,
                          style: AppStyles.styleBold16Black.copyWith(
                            color: tab.key==TabBarCubit.get(context).index?AppColors.white:AppColors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: TabBarCubit.get(context)
                    .views[TabBarCubit.get(context).index],
              ),
            ],
          ),
        );
      },
    );
  }
}
