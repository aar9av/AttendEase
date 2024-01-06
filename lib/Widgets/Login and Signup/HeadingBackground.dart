import 'package:attend_easy/Widgets/Start%20&%20UI/Background.dart';
import 'package:flutter/material.dart';

class HeadingBackground extends StatelessWidget {
  final String heading;

  const HeadingBackground({required this.heading, super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Container(
            height: 250,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(200),
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(100),
              ),
              gradient: LinearGradient(
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor.withAlpha(150),
                  Theme.of(context).primaryColor
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(30),
            child: Text(
              heading,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ]
      ),
    );
  }
}
