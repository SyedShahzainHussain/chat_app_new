import 'package:chat_app_new/config/context_utils.dart';
import 'package:flutter/material.dart';

class SHelperFunction {
  static nextScreen(Widget screen) {
    Navigator.of(SContextUtils.context)
        .push(MaterialPageRoute(builder: (_) => screen));
  }

  static nextScreenAndRemovePrevious(Widget screen) {
    Navigator.of(SContextUtils.context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => screen), (route) => false);
  }
  
}
