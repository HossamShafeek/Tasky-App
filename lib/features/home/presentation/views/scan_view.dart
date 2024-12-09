import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:tasky/config/routes/app_routes.dart';
import 'package:tasky/core/functions/show_snack_bar.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_constants.dart';
import 'package:tasky/core/utils/app_strings.dart';
import 'package:tasky/core/widgets/custom_back_button.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:tasky/features/home/presentation/cubits/tasks_cubit/tasks_state.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key, required this.contextForBloc});

  final BuildContext contextForBloc;

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      await widget.contextForBloc
          .read<TasksCubit>()
          .getTaskById(taskId: scanData.code!);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {
        if (state is GetTaskByIdSuccessState) {
          Navigator.popAndPushNamed(
            context,
            Routes.taskDetailsView,
            arguments: widget.contextForBloc.read<TasksCubit>().taskById,
          );
        }else if(state is GetTaskByIdFailureState){
          showErrorSnackBar(context: context, message: state.error);
        }else if(state is GetTaskByIdLoadingState){
          controller?.stopCamera();
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is GetTaskByIdLoadingState,
          color: Colors.white,
          opacity: 0.5,
          progressIndicator: const CircularProgressIndicator(),
          child: Scaffold(
            appBar: AppBar(
              leading: const CustomBackButton(),
              title: const Text(AppStrings.scan),
            ),
            body: QRView(
              key: GlobalKey(debugLabel: 'QR'),
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: AppColors.primary,
                borderRadius: AppConstants.radius10r,
                cutOutSize: MediaQuery.sizeOf(context).width * 0.8,
                borderWidth: AppConstants.size5h,
                borderLength: AppConstants.size25h,
              ),
            ),
          ),
        );
      },
    );
  }
}
