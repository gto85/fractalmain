import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fractal/feature/authenticaiton/OTPController.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String dialCodeDigits = "+00";
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Padding(padding: const EdgeInsets.only(left: 28,right: 28),
              child: Image.asset("images/_24_fractal.png"),),
            Container(
              margin: EdgeInsets.only(top: 10),
              child:Center(
                  child: Text(
                    "Код Авторизации",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20)
                  )
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 400,
              height: 60,
              child: CountryCodePicker(
                onChanged: (country){
                  setState(() {
                    dialCodeDigits = country.dialCode!;
                  });
                },
                initialSelection: "IT",
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                favorite: ["+7", "RUS"],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10,right: 10,left: 10),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                        hintText: "Номер телефона",
                        prefix: Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(dialCodeDigits),
                        )
                  ),
                maxLength: 12,
                keyboardType: TextInputType.number,

              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (c) => OTPControllerScreen(
                    phone: _controller.text,
                    codeDigits: dialCodeDigits,

                  )));
                },
                child: Text("Далее", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

              ),
            )
          ],
        ),
      ) ,
    );
  }
}
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size){
    var path = Path();
    path.moveTo(size.width, 0.9);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondPoint = Offset(size.width , 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondPoint.dx, secondPoint.dy);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}