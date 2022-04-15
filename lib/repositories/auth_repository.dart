import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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