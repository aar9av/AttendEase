// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../Widgets/Login and Signup/LoginScreen.dart';

class SignOut {

  Future<void> signOutEmail(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      print('Error during sign out: $e');
    }
  }

  Future<void> signOutGoogle(BuildContext context) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      await _auth.signOut();

      await _googleSignIn.signOut();
    } catch (error) {
      print('Error during sign-out: $error');
    }
  }
}