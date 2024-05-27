import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential?> signUpUser(
    String email,
    String password,
    String username,
    String profilePicUrl,
  ) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await _sendUserDataToFirestore(userCredential, username, profilePicUrl);
        return userCredential;
      } else {
        return null;
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<void> _sendUserDataToFirestore(
    UserCredential userCredential,
    String username,
    String profilePicUrl,
  ) async {
    try {
      await firebaseFirestore
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({
        "email": userCredential.user?.email ?? "",
        "uid": userCredential.user?.uid ?? "",
        "username": username,
        "profilePic": profilePicUrl,
        'token': null,
      });
    } catch (e) {
      rethrow;
    }
  }
}
