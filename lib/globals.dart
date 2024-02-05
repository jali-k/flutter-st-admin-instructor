import 'package:educator_app/screens/res/app_colors.dart';
import 'package:flutter/material.dart';

class Globals {
  static void showSnackBar({
    required BuildContext context,
    required String? message,
    required bool isSuccess,
  }) {
    Color bgColor = (isSuccess) ? AppColors.green : AppColors.red;

    final snackBar = SnackBar(
      backgroundColor: bgColor,
      duration: const Duration(seconds: 3),
      content: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Text(
          message ?? '-',
          style: const TextStyle(
            color: AppColors.ligthWhite,
            fontSize: 14,
          ),
        ),
      ),
      action: SnackBarAction(
        label: 'Ok',
        textColor: AppColors.ligthWhite,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree and use it to show a SnackBar.
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
