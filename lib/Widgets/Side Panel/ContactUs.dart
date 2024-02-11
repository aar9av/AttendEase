import 'package:flutter/material.dart';
import '../Start & UI/Background.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
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
                          'Contact Us',
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
                          'Assets/Mail.png',
                          height: 75,
                        ),
                        title: const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.redAccent
                          ),
                        ),
                        subtitle: const Text(
                          'arnavgupta.nitb@gmail.com'
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          'Assets/Linkedin.png',
                          height: 75,
                        ),
                        title: const Text(
                          'LinkedIn',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.blue,
                          ),
                        ),
                        subtitle: const Text(
                            'https://www.linkedin.com/in/aar9av/'
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
                          'GitHub',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: const Text(
                            'https://github.com/aar9av'
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
