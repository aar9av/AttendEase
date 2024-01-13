import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Functionalities/Authentication/LoginWithGoogle.dart';
import '../../Functionalities/Authentication/LoginWithPhone.dart';
import 'Background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneNumber = TextEditingController();
  final otp = TextEditingController();
  String countryCode = '+91';
  String verify = '';
  bool validateName = true;
  bool validatePhoneNumber = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Container(
            height: 250,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(200),
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(100),
              ),
              gradient: LinearGradient(
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor.withAlpha(150),
                  Theme.of(context).primaryColor
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(30),
            child: const Text(
              'Here is your\nfirst step\nwith us.',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Center(
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.all(40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      colors: [
                        Color(0xffddfeff),
                        Color(0xffcfd7ff),
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          keyboardType: TextInputType.phone,
                          controller: phoneNumber,
                          decoration: InputDecoration(
                            prefixText: '+91 ',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)
                            ),
                            labelText: '+91  Enter Phone Number',
                            errorText: validatePhoneNumber ? null : "Invalid Phone Number",
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                              onPressed: () async{
                                setState(() {
                                  validatePhoneNumber = phoneNumber.text.length == 10;
                                });
                                if(validatePhoneNumber) {
                                  String temp = await LoginWithPhone.otpGeneration(context, countryCode+phoneNumber.text);
                                  setState(() {
                                    verify = temp;
                                  });
                                }
                              },
                              child: Text(
                                'Generate OTP',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          keyboardType: TextInputType.phone,
                          controller: otp,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.key),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)
                            ),
                            labelText: 'Enter OTP',
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () async{
                              await LoginWithPhone.loginWithPhone(context, verify, otp.text, countryCode+phoneNumber.text, 'User');
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('or login with'),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            onPressed: (){
                              LoginWithGoogle().loginWithGoogle(context);
                            },
                            icon: Image.asset("Assets/Google.jpg"),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
