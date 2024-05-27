import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushBarMessage {
  static showSuccessDialog(BuildContext context, String message) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(12.0),
      flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(Icons.done_all_rounded, color: Colors.green),
      forwardAnimationCurve: Curves.decelerate,
      borderRadius: BorderRadius.circular(8.0),
    ).show(context);
  }

  static showErrorsDialog(BuildContext context, String message) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(12.0),
      flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(Icons.error, color: Colors.red),
      forwardAnimationCurve: Curves.decelerate,
      borderRadius: BorderRadius.circular(8.0),
    ).show(context);
  }
}
