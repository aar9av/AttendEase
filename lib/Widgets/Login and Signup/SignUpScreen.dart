import 'package:attend_easy/Widgets/Background.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Functionalities/Authentication/SignupUser.dart';
import 'HeadingBackground.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  bool validateName = true;
  bool validateEmail = true;
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
    name.dispose();
    email.dispose();
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
          const HeadingBackground(heading: 'Here is your\nfirst step\nwith us!',),
          Center(
            child: BlurryContainer(
              height: 480,
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
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      controller: name,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        labelText: 'Enter Full Name',
                        errorText: validateName ? null : "Name Can't be empty",
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.mail),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        labelText: 'Enter Email',
                        errorText: validateEmail ? null : "Invalid Email",
                      ),
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
                            validateName = name.text.isNotEmpty;
                            validateEmail = email.text.contains('@');
                            validatePasswordLength = password.text.length >= 8;
                            validatePassword = password.text == confirmPassword.text;
                          });
                          if(validateEmail && validatePassword && validatePasswordLength) {
                            SignupUser(
                              name: name.text,
                              email: email.text,
                              password: password.text,
                            ).signupUser(context);
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
                            MaterialPageRoute(builder: (context) => const LoginScreen())
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
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
