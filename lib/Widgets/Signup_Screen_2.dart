// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/services.dart';

import 'DashBoard_Screen.dart';
import 'Login_Screen.dart';
import 'Background.dart';

class Signup_Screen_2 extends StatefulWidget {
  const Signup_Screen_2({super.key});

  @override
  State<Signup_Screen_2> createState() => _Signup_Screen_2State();
}

class _Signup_Screen_2State extends State<Signup_Screen_2> {

  final mobileNumber = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  bool validateMobile = true;
  bool validatePasswordLength = true;
  bool validatePassword = true;


  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    mobileNumber.dispose();
    password.dispose();
    confirmPassword.dispose();
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
              'Here is your\nfirst step\nwith us!',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: BlurryContainer(
              height: 450,
              width: 300,
              blur: 5,
              color: Colors.transparent.withOpacity(0.05),
              padding: const EdgeInsets.all(8),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: mobileNumber,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        labelText: 'Mobile Number',
                        errorText: validateMobile ? null : "Invalid Mobile Number",
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: password,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.key),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        labelText: 'Password',
                        errorText: validatePasswordLength ? null : "Password must contain at least 8 characters",
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            },
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: confirmPassword,
                      obscureText: confirmPasswordVisible,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.key),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        labelText: 'Confirm Password',
                        errorText: validatePassword ? null : "Password does not match",
                        suffixIcon: IconButton(
                          icon: Icon(confirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              confirmPasswordVisible = !confirmPasswordVisible;
                            },
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: (){
                          setState(() {
                            validateMobile = mobileNumber.text.length == 10;
                            validatePasswordLength = password.text.length >= 8;
                            validatePassword = password == confirmPassword;
                          });
                          if(validateMobile && validatePassword && validatePasswordLength) {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (
                                    context) => const DashBoard_Screen())
                            );
                          }
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const Login_Screen())
                        );
                      },
                      child: Text(
                        'Already have an Account? Login',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                          'or register with'
                      ),
                    ),
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

                        },
                        icon: Image.asset("Assets/Images/Google.jpg"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
