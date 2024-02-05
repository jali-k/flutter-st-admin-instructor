import 'package:educator_app/screens/res/app_colors.dart';
import 'package:flutter/material.dart';

class ConfirmationPopup {
  final BuildContext _context;

  ConfirmationPopup(this._context);

  void show({
    String? title,
    required String message,
    required void Function() callbackOnYesPressed,
  }) {
    showDialog(
      context: _context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(
                width: 2,
                color: AppColors.red,
              )),
          backgroundColor: AppColors.backGround,
          surfaceTintColor: AppColors.backGround,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: (title != null),
                  child: Text(
                    title ?? '',
                    style: const TextStyle(
                      color: AppColors.ligthWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 40,
                      // width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        color: AppColors.ligthWhite,
                        border: Border.all(
                          color: AppColors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        style: null,
                        child: const Text(
                          'No',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      // width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        style: null,
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            color: AppColors.ligthWhite,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          callbackOnYesPressed();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
