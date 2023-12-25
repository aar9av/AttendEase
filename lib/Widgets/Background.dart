import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/Images/Background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      )
    );
  }
}
