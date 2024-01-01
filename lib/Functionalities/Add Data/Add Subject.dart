import 'package:attend_easy/Widgets/Add%20and%20Edit%20Subject/AddSubject2.dart';
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
      String subjectLocation,
      List<TimeSlot> timeSlots)
  async {
    String? uid = await fetchUid();

    try {
      CollectionReference userSubjects =
      FirebaseFirestore.instance.collection('users/$uid/subjects');

      List<Map<String, dynamic>> timeSlotsData = timeSlots.map((slot) {
        return {
          'isChecked': slot.isChecked,
          'time': {
            'hour': slot.time.hour,
            'minute': slot.time.minute,
          },
        };
      }).toList();

      await userSubjects.add({
        'name': subjectName,
        'code': subjectCode,
        'coordinator': subjectCoordinator,
        'minAttendancePercentage': minAttendancePercentage,
        'location': subjectLocation,
        'timeSlots': timeSlotsData,
      });

      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
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
