import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fractal/homeScreen.dart';
import 'package:pinput/pinput.dart';

class OTPControllerScreen extends StatefulWidget {
  final String phone;
  final String codeDigits;
  OTPControllerScreen({required this.phone, required this.codeDigits});
  @override
  State<OTPControllerScreen> createState() => _OTPControllerScreenState();
}

class _OTPControllerScreenState extends State<OTPControllerScreen> {

  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
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

  @override
  void initState(){
    super.initState();
    verifyPhoneNumber();
  }
  verifyPhoneNumber() async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${widget.codeDigits + widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential).then((value) =>
          {
            if(value.user !=null){
              Navigator.of(context).push(MaterialPageRoute(builder: (c)=>HomeScreen()))
            }
          });
        },
        verificationFailed: (FirebaseAuthException e)
        {
          SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 3),
          );
        },
        codeSent: (String vID, int? resendToken){
          setState(() {
          varificationCode = vID;
          });
        },
        codeAutoRetrievalTimeout: (String vID){
          setState(() {
            varificationCode = vID;
          });
        },
      timeout: Duration(seconds: 60)
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolkey,
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
