import 'package:attend_easy/Widgets/Login%20and%20Signup/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupUser {
  final String name;
  final String email;
  final String password;

  SignupUser({
    required this.name,
    required this.email,
    required this.password,
  });

  Future<void> signupUser(BuildContext context) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'Name': name,
        'email': email,
        'password': password,
      }).catchError((error) {});

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Signup Error'),
            content: Text('$e'),
            backgroundColor: Colors.white,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
