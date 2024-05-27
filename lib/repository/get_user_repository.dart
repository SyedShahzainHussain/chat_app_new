import 'package:chat_app_new/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserRepository {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getUserData() async {
    try {
      final data = await firebaseFirestore.collection('Users').get();
      return data.docs.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }
}
  