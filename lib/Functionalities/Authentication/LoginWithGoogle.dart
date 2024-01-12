import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Widgets/Dashboard/DashBoardScreen.dart';

class LoginWithGoogle {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credentials);

      if (userCredential.additionalUserInfo!.isNewUser) {
        // Create a user document in the 'users' collection
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': userCredential.user!.displayName,
          'email': userCredential.user!.email,
          'password': 'GoogleSignIN',
          'college': '',
          'course': '',
          // Add other user details as needed
        });
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashBoardScreen()),
      );

      return userCredential;
    } catch (error) {
      print('Error during Google sign-in: $error');
      return null;
    }
  }
}
