import 'package:flutter/material.dart';
import '../../Functionalities/Authentication/LoginWithGoogle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                  colors: [
                    Colors.cyan.shade300,
                    Colors.blueAccent.shade400,
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'Assets/Logo.png',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Attend Ease',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                    ),
                    const Text(
                      'Login/Register',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 40, right: 40),
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
                  ],
                ),
              ]
            ),
          ]
      ),
    );
  }
}
