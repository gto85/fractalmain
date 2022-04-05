import 'package:firebase_auth/firebase_auth.dart';

class UserInfo1 {
  String? id;
  UserInfo1.fromFirebase(User user){
    id = user.uid;

  }
}