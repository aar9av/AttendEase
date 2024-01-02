import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  final String name;
  final String email;
  final String password;

  UserData({
    required this.name,
    required this.email,
    required this.password,
  });

  factory UserData.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserData(
      name: data['name'],
      email: data['email'],
      password: data['password'],
    );
  }
}

class UserDataService {
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

  Future<String?> fetchUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }
}