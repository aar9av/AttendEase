// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/services.dart';

import 'Login_Screen.dart';
import 'Signup_Screen_2.dart';
import 'Background.dart';

class Signup_Screen_1 extends StatefulWidget {
  const Signup_Screen_1({super.key});

  @override
  State<Signup_Screen_1> createState() => _Signup_Screen_1State();
}

class _Signup_Screen_1State extends State<Signup_Screen_1> {

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  bool validateFirstName = true;
  bool validateLastName = true;
  bool validateEmail = true;

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
    firstName.dispose();
    lastName.dispose();
    email.dispose();
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
                      keyboardType: TextInputType.text,
                      controller: firstName,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        labelText: 'First Name',
                        errorText: validateFirstName ? null : "First Name cannot be Empty",
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      controller: lastName,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        labelText: 'Last Name',
                        errorText: validateLastName ? null : "Last Name cannot be Empty",
                      ),
                    ),
                    const SizedBox(
                      height: 5,
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
                            validateFirstName = firstName.text.isNotEmpty;
                            validateLastName = lastName.text.isNotEmpty;
                            validateEmail = email.text.isNotEmpty && email.text.contains('@');
                          });
                          if(validateEmail && validateFirstName && validateLastName) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Signup_Screen_2(),
                                )
                            );
                          }
                        },
                        child: const Text(
                          'Next',
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
                            MaterialPageRoute(builder: (context) => const Login_Screen()),
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
