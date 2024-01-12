import 'package:flutter/material.dart';
import '../Start & UI/Background.dart';

class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share'),
      ),
      body: Stack(
        children: [
          const Background(),
          Center(
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                    colors: [
                      Color(0xffddfeff),
                      Color(0xffcfd7ff),
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Share',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          'Assets/Android.png',
                          height: 75,
                        ),
                        title: const Text(
                          'APK File',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.lightGreen
                          ),
                        ),
                        subtitle: const Text(
                            'https://github.com/aar9av/AttendEase-APKFile'
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          'Assets/GitHub.png',
                          height: 75,
                        ),
                        title: const Text(
                          'Source Code',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: const Text(
                            'https://github.com/aar9av/AttendEase'
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Back',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
