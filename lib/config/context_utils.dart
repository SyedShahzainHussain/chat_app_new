import 'package:flutter/material.dart';

class SContextUtils {
  static GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState>? get navaigatorKey => navigatorkey;

  static NavigatorState? get navigator => navaigatorKey?.currentState;

  static BuildContext get context => navigator!.overlay!.context;
}
