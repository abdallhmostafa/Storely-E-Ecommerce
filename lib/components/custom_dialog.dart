import 'package:flutter/material.dart';

class CustomErrorMessage {
  static String messageError = '';
  static bool isError = true;
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> errorMessage(
      BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      content: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle,
            color: Colors.white,
            size: 35.0,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                messageError,
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              )
            ],
          ))
        ]),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? Colors.red : Colors.green,
      elevation: 3.0,
    ));
  }
}
