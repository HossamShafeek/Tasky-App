import 'package:flutter/material.dart';
import 'package:tasky/core/animations/fade_transition_animation.dart';
import 'package:tasky/core/api/end_points.dart';
import 'package:tasky/core/widgets/custom_network_image.dart';
import 'package:tasky/features/home/domain/entities/task_entity.dart';
import 'package:tasky/features/home/presentation/widgets/task_details_qr_code.dart';
import 'package:tasky/features/home/presentation/widgets/task_details_section.dart';

class TaskDetailsViewBody extends StatelessWidget {
  const TaskDetailsViewBody({super.key, required this.taskEntity});

  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeTransitionAnimation(
            duration: const Duration(milliseconds: 600),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height/3.4,
              child: CustomNetworkImage(
                borderRadius: 0,
                image: '${EndPoints.baseUrl}${EndPoints.viewImages}${taskEntity.image!}',
              ),
            ),
          ),
          TaskDetailsSection(taskEntity: taskEntity),
          TaskDetailsQrCode(taskId: taskEntity.id),
        ],
      ),
    );
  }
}
