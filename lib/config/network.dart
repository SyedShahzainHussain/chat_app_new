import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class NetworkManager {
  final Connectivity connectivity = Connectivity();
  Future<bool> isConnected() async {
    try {
      final result = await connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }
}
