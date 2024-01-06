// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Widgets/Add and Edit Subject/AddSubject2.dart';
import '../../Widgets/Add and Edit Subject/EditSubject2.dart';

class Subject {

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


  static Future<List<Map<String, dynamic>>> fetchAllSubjects() async {
    String? uid = await fetchUid();
    CollectionReference userSubjects = FirebaseFirestore.instance
        .collection('users/$uid/subjects');

    QuerySnapshot<Object?> snapshot = await userSubjects.get();

    return List<Map<String, dynamic>>.from(snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id; // Include the document ID in the data
      return data;
    }).toList());
  }


  static Future<Map<String, dynamic>> fetchSubjectData(String subjectId) async {
    try {
      String? uid = await fetchUid();
      DocumentSnapshot<Object?> snapshot = await FirebaseFirestore.instance
          .collection('users/$uid/subjects')
          .doc(subjectId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        data['id'] = snapshot.id; // Include the document ID in the data

        if (data.containsKey('timeSlots')) {
          List<NewTimeSlot> timeSlots = (data['timeSlots'] as List<dynamic>)
              .map((timeSlot) {
            return NewTimeSlot(
              isChecked: timeSlot['isChecked'] ?? false,
              time: TimeOfDay(
                hour: timeSlot['time']['hour'] ?? 0,
                minute: timeSlot['time']['minute'] ?? 0,
              ),
            );
          }).cast<NewTimeSlot>().toList();

          data['timeSlots'] = timeSlots;
        }

        return data;
      } else {
        throw Exception('Subject not found');
      }
    } catch (e) {
      print('Error fetching subject data: $e');
      rethrow;
    }
  }


  static Future<void> editSubject(
      BuildContext context,
      String subjectId,
      String subjectName,
      String subjectCode,
      String subjectCoordinator,
      int minAttendancePercentage,
      String subjectLocation,
      List<NewTimeSlot> timeSlots,
      ) async {
    try {
      String? uid = await fetchUid();

      if (uid != null) {
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

        // Modify the document instead of adding a new one
        await userSubjects.doc(subjectId).update({
          'name': subjectName,
          'code': subjectCode,
          'coordinator': subjectCoordinator,
          'minAttendancePercentage': minAttendancePercentage,
          'location': subjectLocation,
          'timeSlots': timeSlotsData,
        });
      }
    } catch (e) {
      print('Error editing subject: $e');
      throw e;
    }
  }


  static Future<void> deleteSubject(BuildContext context, String subjectId) async {
    try {
      String? uid = await fetchUid();

      if (uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('subjects')
            .doc(subjectId)
            .delete();
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
