import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<User?> getCurrentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return user.user!.uid.toString();
  }

  Future<String> signUp(String email, String password) async {
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return user.user!.uid.toString();
  }

  Future<User?> getCurrentUser() async {
    User? user = await _firebaseAuth.currentUser;
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}



authorizationPin(pin,varificationCode) async{
  try{
    await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: varificationCode!,
        smsCode: pin)
      ).then((value) {
      if(value.user !=null)
      {

      }
    });
  }
  catch(e){
    const SnackBar(
      content: Text("Неверный код авторизации"),
      duration: Duration(seconds: 3),
    );
  }
}
verifyPhoneNumber(String varificationCode) async{
  String? phone;
  String? codeDigits;
  await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: codeDigits! + phone!,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential).then((value) =>
        {
          if(value.user !=null){

          }
        });
      },
      verificationFailed: (FirebaseAuthException e)
      {
        SnackBar(
          content: Text(e.message.toString()),
          duration: const Duration(seconds: 3),
        );
      },
      codeSent: (String vID, int? resendToken){
          varificationCode = vID;
      },
      codeAutoRetrievalTimeout: (String vID){
          varificationCode = vID;
      },
      timeout: const Duration(seconds: 60)
  );
}