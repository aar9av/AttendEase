import 'package:cloud_firestore/cloud_firestore.dart';
import 'Users.dart';

class Attendance {

  static void resetAttendanceStatus(id) async{
    try {
      String? uid = await Users.fetchUid();

      if(uid != null){
        CollectionReference userSubjects =
        FirebaseFirestore.instance.collection('users/$uid/subjects');

        await userSubjects.doc(id).update({
          'today': false,
        });
      }
    } catch (e) {
      print ('Error in updating Attendance Status: $e');
    }
  }

  static void setAttendanceStatus(id) async{
    try {
      String? uid = await Users.fetchUid();

      if(uid != null){
        CollectionReference userSubjects =
        FirebaseFirestore.instance.collection('users/$uid/subjects');

        await userSubjects.doc(id).update({
          'today': true,
        });
      }
    } catch (e) {
      print ('Error in updating Attendance Status: $e');
    }
  }

  static addAttendanceDocument(String subjectId, String status) async {
    try {
      String? uid = await Users.fetchUid();

      CollectionReference attendanceCollection = FirebaseFirestore.instance
          .collection('users/$uid/subjects/$subjectId/attendance');

      DateTime now = DateTime.now();

      await attendanceCollection.add({
        'dateTime': Timestamp.fromDate(now),
        'status': status,
      });
    } catch (e) {
      print('Error in adding attendance document: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchAttendance(String subjectID) async {
    String? uid = await Users.fetchUid();

    CollectionReference subjectAttendance = FirebaseFirestore.instance
        .collection('users/$uid/subjects/$subjectID/attendance');

    QuerySnapshot<Object?> snapshot = await subjectAttendance.get();

    return List<Map<String, dynamic>>.from(snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id; // Include the document ID in the data
      return data;
    }).toList());
  }
}