import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:tasky/core/functions/show_snack_bar.dart';

void saveToClipboard({
  required BuildContext context,
  required String phone,
}) {
  Clipboard.setData(ClipboardData(text: phone));
  showSuccessSnackBar(context: context, message: 'Phone number copied');
}