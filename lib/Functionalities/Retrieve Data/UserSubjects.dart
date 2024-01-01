import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SubjectService {
  static Future<List<Map<String, dynamic>>> fetchSubjects() async {
    String? uid = await _fetchUid();
    CollectionReference userSubjects =
    FirebaseFirestore.instance.collection('users/$uid/subjects');

    QuerySnapshot<Object?> snapshot = await userSubjects.get();

    return List<Map<String, dynamic>>.from(snapshot.docs.map((doc) => doc.data()).toList());
  }


  static Future<String?> _fetchUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }
}
