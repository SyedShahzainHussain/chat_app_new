import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class UploadImagerepository {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImageToFirebaseStorage(File file) async {
    try {
      final getImageType = file.path.split('.').last;
      final Reference reference = firebaseStorage
          .ref()
          .child("profilePic")
          .child('${file.path}.$getImageType');

      final UploadTask uploadTask = reference.putFile(file);
      final TaskSnapshot snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (_) {
      rethrow;
    }
  }
}
