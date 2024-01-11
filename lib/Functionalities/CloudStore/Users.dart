// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData {
  final String name;
  final String email;
  final String password;
  final String college;
  final String course;

  UserData({
    required this.name,
    required this.email,
    required this.password,
    required this.college,
    required this.course,
  });

  factory UserData.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserData(
      name: data['name'],
      email: data['email'],
      password: data['password'],
      college: data['college'],
      course: data['course'],
    );
  }
}

class Users {
  Future<UserData> getUserData() async {
    String? uid = await fetchUid();

    try {
      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid!).get();

      if (userDoc.exists) {
        return UserData.fromSnapshot(userDoc);
      } else {
        throw Exception('User document does not exist');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      throw e;
    }
  }

  static Future<void> editUser(
      BuildContext context,
      String name,
      String college,
      String course,
      String password,
      ) async {
    try {
      String? uid = await fetchUid();

      if (uid != null) {
        CollectionReference userSubjects =
        FirebaseFirestore.instance.collection('users');

        await userSubjects.doc(uid).update({
          'name': name,
          'college': college,
          'course': course,
          'password': password,
        });
      }
    } catch (e) {
      print('Error editing subject: $e');
      throw e;
    }
  }

  static Future<void> deleteUser() async {
    try {
      String? uid = await fetchUid();

      if (uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .delete();
      }
    } catch (e) {
      print('Error deleting subject: $e');
      throw e;
    }
  }

  static Future<void> deleteUserAuth() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.delete();
      } else {
        print('No user is currently signed in.');
      }
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  static Future<String?> fetchUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }
}