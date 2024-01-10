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
                      Row(
                        children: [
                          Icon (
                            Icons.mail,
                            size: 40,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            '  arnavgupta.mca@gmail.com',
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon (
                            Icons.account_box_rounded,
                            size: 40,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            '  https://www.linkedin.com/in/aar9av/',
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon (
                            Icons.ad_units_rounded,
                            size: 40,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            '  https://github.com/aar9av',
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
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
