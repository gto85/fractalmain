import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fractal/models/user.dart';
import 'package:pinput/pinput.dart';

import '../../../main.dart';
import '../../../repositories/auth_repository.dart';
import '../../planed/page.dart';



class OtpDetailsScreen extends StatelessWidget {
  final String codeDigits;
  final String phone;
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();
  String? varificationCode;
  final pinOTPCodeTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  OtpDetailsScreen({required this.codeDigits, required this.phone});
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
                  verifyPhoneNumber("");
                },
                child: Text(
                    "Подтверждение: ${codeDigits}-${phone}",
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
                      pageStacksBloc.currentStackBloc?.push(PlanedPage());
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