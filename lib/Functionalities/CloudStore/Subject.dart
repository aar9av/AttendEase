import 'package:attend_easy/Widgets/Add%20and%20Edit%20Subject/AddSubject2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Subject {

  static Future<List<Map<String, dynamic>>> fetchSubjects() async {
    String? uid = await fetchUid();
    CollectionReference userSubjects = FirebaseFirestore.instance.collection('users/$uid/subjects');

    QuerySnapshot<Object?> snapshot = await userSubjects.get();

    return List<Map<String, dynamic>>.from(snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id; // Include the document ID in the data
      return data;
    }).toList());
  }


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
    } catch (e) {
      print('Error adding subjects: $e');
      throw e;
    }
  }


  static Future<void> deleteSubject(BuildContext context, String subjectId) async {
    try {
      String? uid = await fetchUid();

      if (uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).collection('subjects').doc(subjectId).delete();
      }
    } catch (e) {
      print('Error deleting subject: $e');
      throw e;
    }
  }


  static Future<String?> fetchUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }
}
