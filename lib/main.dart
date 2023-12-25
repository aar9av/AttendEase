// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import 'Widgets/Login_Screen.dart';


void main() => runApp(new attend_easy());

class attend_easy extends StatelessWidget {
  const attend_easy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blueAccent,
      ),
      home: const Login_Screen(),
    );
  }
}
