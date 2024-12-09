import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/core/utils/app_constants.dart';

class TaskDetailsQrCode extends StatelessWidget {
  const TaskDetailsQrCode({super.key, required this.taskId});

  final String taskId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(AppConstants.defaultPadding),
      child: Center(
        child: AspectRatio(

         aspectRatio: 1,
          child: QrImageView(
            data: taskId,
            // The ID you want to encode
            version: QrVersions.auto,
          ),
        ),
      ),
    );
  }
}
