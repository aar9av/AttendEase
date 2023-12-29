// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Widgets/Login and Signup/LoginScreen.dart';

class SignOut {
  // Sign out for email/password authentication
  Future<void> signOutEmail(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to the login screen or any other screen after sign out
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      print('Error during sign out: $e');
    }
  }

  // Sign out for Google authentication
  Future<void> signOutGoogle(BuildContext context) async {
    try {
      // Add your Google sign out logic here (if applicable)
      // For example, using GoogleSignIn.signOut()

      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Navigate to the login screen or any other screen after sign out
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      print('Error during sign out: $e');
    }
  }
}