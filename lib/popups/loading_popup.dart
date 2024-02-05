import 'package:educator_app/screens/res/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingPopup {
  final BuildContext _context;

  LoadingPopup(this._context);

  void show({String? loadingMessage}) {
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: (() {
            return Future.value(false);
          }),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: AppColors.backGround,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      backgroundColor: AppColors.ligthWhite,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      (loadingMessage != null) ? loadingMessage : 'Please wait',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void dismiss() {
    Navigator.pop(_context);
  }
}
