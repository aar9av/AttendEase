import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import '../../Functionalities/Attendance/MarkAttendance.dart';
import '../Dashboard/DashBoardScreen.dart';
import '../Login and Signup/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Workmanager().initialize(callbackDispatcher);
  String task = DateTime.now().minute.toString();
  Workmanager().registerPeriodicTask(
    task,
    'markAttendance',
    initialDelay: const Duration(seconds: 2),
    frequency: const Duration(minutes: 30),
  );
  runApp(AttendEase());
}

class AttendEase extends StatelessWidget {
  AttendEase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light().copyWith(
            primary: Colors.blueAccent,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
          )
        ),
      ),
      home:
      StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return snapshot.hasData ? const DashBoardScreen() : const LoginScreen();
        },
      ),
    );
  }
}


callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await Firebase.initializeApp();
    if(FirebaseAuth.instance.currentUser != null) {
      await markAttendance();
    }
    return Future.value(true);
  });
}
