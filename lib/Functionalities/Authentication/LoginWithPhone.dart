// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Dashboard/DashBoardScreen.dart';

class LoginWithPhone {

  static Future<String> otpGeneration(BuildContext context, String phoneNumber) async {
    try {
      String verify = '';
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          showAlertBox(context, '$e');
        },
        codeSent: (String verificationId, int? resendToken) {
          verify = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return verify;
    } catch (e) {
      showAlertBox(context, '$e');
      return 'error';
    }
  }


  static Future<void> loginWithPhone(BuildContext context, String verify, String otp, String phone, String name) async {
      FirebaseAuth auth = FirebaseAuth.instance;

      await auth.verifyPhoneNumber(

        phoneNumber: phone,
        codeSent: (String verificationId, int? resendToken) async {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verify, smsCode: otp);
          await auth.signInWithCredential(credential);
        },

        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          UserCredential userCredential = await auth.signInWithCredential(phoneAuthCredential);
          var userDoc = await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();
          if (!userDoc.exists) {
            await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
              'name': name,
              'email': phone,
              'college': '',
              'course': '',
            });
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashBoardScreen()),
          );
        },

        verificationFailed: (FirebaseAuthException e) {
          showAlertBox(context, '$e');
        },

        codeAutoRetrievalTimeout: (String verificationId) {},
      );
  }

   static Future<void> showAlertBox (BuildContext context, String error) async {
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           title: const Text('Login Error'),
           content: Text(error),
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
