// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/services.dart';

import 'Signup_Screen_1.dart';
import 'Background.dart';
import 'DashBoard_Screen.dart';



class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {

  final emailOrMobile = TextEditingController();
  final password = TextEditingController();
  bool passwordVisible = true;
  bool validateUsername = true;
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
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    emailOrMobile.dispose();
    password.dispose();
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
              'Already\nHave An\nAccount?',
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailOrMobile,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        labelText: 'Email/Mobile Number',
                        errorText: validateUsername ? null : "Invalid Email or Mobile Number",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                        errorText: validatePassword ? null : "Password must contain at least 8 characters",
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
                      height: 20,
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
                              validateUsername =
                              emailOrMobile.text.isNotEmpty &&
                                  ( emailOrMobile.text.length == 10 ||
                                      emailOrMobile.text.contains('@'));
                              validatePassword = password.text.length>=8;
                            });
                            if(validateUsername && validatePassword) {
                              print(emailOrMobile);
                              print(password);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (
                                      context) => const DashBoard_Screen())
                              );
                            }
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
                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Signup_Screen_1())
                        );
                      },
                      child: Text(
                        'New User? Register Now',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Center(
                        child: Text(
                            'or login with'
                        ),
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
