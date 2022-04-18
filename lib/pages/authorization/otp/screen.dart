import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fractal/models/user.dart';
import 'package:pinput/pinput.dart';

import '../../../repositories/auth_repository.dart';



class OtpDetailsScreen extends StatelessWidget {
  final UserInfo1 user;

  OtpDetailsScreen({
    required this.user,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("СМС подтверждение"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.all(8.0),
            child: Image.asset("images/_24_fractal.png"),),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Center(
              child: GestureDetector(
                onTap: (){
                  verifyPhoneNumber();
                },
                child: Text(
                    "Подтверждение: ${widget.codeDigits}-${widget.phone}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(40),
            child: Pinput(
              length: 6,
              focusNode: _pinOTPCodeFocus,
              controller: _pinOTPCodeController,
              submittedPinTheme: pinOTPCodeTheme,
              followingPinTheme: pinOTPCodeTheme,
              focusedPinTheme: pinOTPCodeTheme,
              pinAnimationType: PinAnimationType.rotation,
              onSubmitted: (pin) async{
                try{
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider
                      .credential(
                      verificationId: varificationCode!,
                      smsCode: pin)
                  ).then((value) {
                    if(value.user !=null)
                    {
                      Navigator.of(context).push(MaterialPageRoute(builder:(c)=>HomeScreen()));
                    }
                  });
                }
                catch(e){
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Неверный код авторизации"),
                        duration: Duration(seconds: 3),
                      )
                  );
                }
              },
            ),),

        ],
      ),
    );
  }
}