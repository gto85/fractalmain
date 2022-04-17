import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fractal/repositories/OTPController.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String dialCodeDigits = "+00";
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100,),
            Padding(padding: const EdgeInsets.only(left: 28,right: 28),
              child: Image.asset("images/_24_fractal.png"),),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child:const Center(
                  child: Text(
                    "Код Авторизации",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20)
                  )
              ),
            ),
            const SizedBox(height: 50),
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
                favorite: const ["+7", "RUS"],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                        hintText: "Номер телефона",
                        prefix: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(dialCodeDigits),
                        )
                  ),
                maxLength: 12,
                keyboardType: TextInputType.number,

              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (c) => OTPControllerScreen(
                    phone: _controller.text,
                    codeDigits: dialCodeDigits,

                  )));
                },
                child: const Text("Далее", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

              ),
            )
          ],
        ),
      ) ,
    );
  }
}
