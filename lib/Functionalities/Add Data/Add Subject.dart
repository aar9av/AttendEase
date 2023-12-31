import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Widgets/Dashboard/DashBoardScreen.dart';

class AddSubject {

  static Future<void> addSubject(
      BuildContext context,
      String subjectName,
      String subjectCode,
      String subjectCoordinator,
      int minAttendancePercentage,
      String subjectLocation)
  async {
    String? uid = await fetchUid();

    try {
      CollectionReference userSubjects =
      FirebaseFirestore.instance.collection('users/$uid/subjects');
      await userSubjects.add({
        'name': subjectName,
        'code': subjectCode,
        'coordinator': subjectCoordinator,
        'minAttendancePercentage': minAttendancePercentage,
        'location': subjectLocation,
      });

      Navigator.pop(context as BuildContext);
      Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => const DashBoardScreen())
      );
    } catch (e) {
      print('Error adding subjects: $e');
      throw e;
    }
  }

  static Future<String?> fetchUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }
}
