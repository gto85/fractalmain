import 'package:firebase_auth/firebase_auth.dart';
import 'package:fractal/models/user.dart';



class AuthService{
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  Future<UserInfo1?> signInWithEmailAndPassword(String email, String password) async{
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return UserInfo1.fromFirebase(user!);
    }catch(e){
      return null;
    }
  }
  Future<UserInfo1?> registerWithEmailAndPassword(String email, String password) async{
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return UserInfo1.fromFirebase(user!);
    }catch(e){
      return null;
    }
  }
  Future logOut() async{
    await _fAuth.signOut();
  }
  Stream<UserInfo1?> get currentUser {
    return _fAuth.authStateChanges()
        .map((User?  user) => user !=null ? UserInfo1.fromFirebase(user) : null);
   }
  }