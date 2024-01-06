import 'package:attend_easy/Widgets/Start%20&%20UI/LoadingPage.dart';
import 'package:attend_easy/Widgets/Login%20and%20Signup/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../Dashboard/DashBoardScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AttendEase());
}

class AttendEase extends StatelessWidget {
  const AttendEase({super.key});

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
      FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();    ///Splash Screen
          } else{
            return (snapshot.hasData)?
            const DashBoardScreen():
            const LoginScreen(); ///Main Screen
          }
        },
      )
    );
  }
}
