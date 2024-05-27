import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id, userName, email, profilePic;
  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.profilePic,
  });

  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return UserModel(
          id: document.id,
          userName: data!['username'],
          email: data['email'],
          profilePic: data['profilePic']);
    } else {
      return empty();
    }
  }

  static UserModel empty() =>
      UserModel(id: "", userName: "", email: "", profilePic: "");
}
