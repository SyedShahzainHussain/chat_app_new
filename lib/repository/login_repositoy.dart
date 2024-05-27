import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> loginUser(String email, String password) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (_) {
      rethrow;
    }
  }
}
