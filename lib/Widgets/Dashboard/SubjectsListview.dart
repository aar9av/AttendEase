// ignore_for_file: use_build_context_synchronously

import 'package:attend_easy/Functionalities/CloudStore/Subject.dart';
import 'package:flutter/material.dart';
import 'DashBoardScreen.dart';
import '../Start & UI/Background.dart';
import 'SubjectPanel.dart';


class SubjectsListview extends StatefulWidget {
  const SubjectsListview({super.key});

  @override
  State<SubjectsListview> createState() => _SubjectsListviewState();
}

class _SubjectsListviewState extends State<SubjectsListview> {
  late List<Map<String, dynamic>> subjects = [];

  @override
  void initState() {
    super.initState();
    _fetchSubjects();
  }

  Future<void> _fetchSubjects() async {
    List<Map<String, dynamic>> fetchedSubjects = await Subject.fetchAllSubjects();
    setState(() {
      subjects = fetchedSubjects;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            const Background(),
            ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: subjects.length,
              itemBuilder: (context, index){
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: Dismissible(
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    key: ValueKey<String>(subjects[index]['id']?.toString() ?? ''),
                    onDismissed: (direction){
                        showDialog<int>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Alert'),
                            content: const Text('Are you sure you want to delete this Subject !!!'),
                            actions: [
                              TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const DashBoardScreen())
                                  );
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await Subject.deleteSubject(context, subjects[index]['id'].toString());
                                  const snackBar = SnackBar(
                                    content: Text(
                                      'This Subject is deleted!',
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  _fetchSubjects();
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const DashBoardScreen())
                                  );
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
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
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SubjectPanel(subjectId: subjects[index]['id'].toString())),
                            );
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              Icons.book,
                              size: 40,
                              color: Colors.black.withAlpha(150),
                            ),
                            title: Text(
                              subjects[index]['name'] ?? '',
                              style: TextStyle(
                                color: Colors.black.withAlpha(200),
                                fontSize: 22,
                              ),
                            ),
                            subtitle: Text(
                              subjects[index]['coordinator'] ?? '',
                              style: TextStyle(
                                color: Colors.black.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                            trailing: Text(
                              '${subjects[index]['minAttendancePercentage']}%',
                              style: TextStyle(
                                color: Colors.black.withAlpha(150),
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ]
      ),
    );
  }
}