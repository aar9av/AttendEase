// ignore_for_file: camel_case_types

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

import 'Background.dart';


class Subject_Panel extends StatefulWidget {
  const Subject_Panel({super.key});

  @override
  State<Subject_Panel> createState() => _Subject_PanelState();
}

class _Subject_PanelState extends State<Subject_Panel> {
  List<String> date = ["Mon, 12 Nov", "Wed, 14 Nov", "Fri, 16 Nov", "Sun, 18 Nov", "Tue, 20 Nov", "Thu, 22 Nov", "Sat, 24 Nov", "Mon, 26 Nov", "Wed, 28 Nov", "Fri, 30 Nov"];
  List<String> attendance = ["Present", "Present", "Absent", "Present", "Present", "Absent", "Present", "Present", "Absent", "Present", "Present", "Absent", "Present", "Present", "Absent", "Present", "Present", "Absent", "Present", "Present"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Subject')),
        ),
        body: Stack(
          children : [
            const Background(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: BlurryContainer(
                    blur: 5,
                    color: Colors.transparent.withOpacity(0.05),
                    padding: const EdgeInsets.all(20),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: const Center(
                      child: Text(
                        'Calendar',
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: BlurryContainer(
                    blur: 5,
                    color: Colors.transparent.withOpacity(0.05),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: const Center(
                      child: Text(
                        'Month',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height-450,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: BlurryContainer(
                    blur: 5,
                    color: Colors.transparent.withOpacity(0.05),
                    padding: const EdgeInsets.all(20),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: ListView.builder(
                      itemCount: date.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text(
                            date[index],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          trailing: Text(
                            attendance[index],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}