import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';

Color getStatusColor({required String status}){
  switch(status.toLowerCase().replaceAll(' ', '')){
    case 'waiting':
      return AppColors.red;
      case 'finished':
      return AppColors.blue;
    default:
      return AppColors.primary;
  }
}

Color getStatusBackgroundColor({required String status}){
  switch(status.toLowerCase().replaceAll(' ', '')){
    case 'waiting':
      return AppColors.redWithOpacity;
    case 'finished':
      return AppColors.blueWithOpacity;
    default:
      return AppColors.primaryWithOpacity;
  }
}

Color getStatusPriorityColor({required String status}){
  switch(status.toLowerCase().replaceAll(' ', '')){
    case 'low':
      return AppColors.blue;
    case 'high':
      return AppColors.red;
    default:
      return AppColors.primary;
  }
}