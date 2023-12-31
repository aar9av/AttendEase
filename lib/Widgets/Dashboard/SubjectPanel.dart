import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Add and Edit Subject/EditSubject1.dart';
import '../Start & UI/Background.dart';


class SubjectPanel extends StatefulWidget {
  final String subjectId;

  SubjectPanel({Key? key, required this.subjectId}) : super(key: key);

  @override
  State<SubjectPanel> createState() => _SubjectPanelState();
}

class _SubjectPanelState extends State<SubjectPanel> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Subject')),
        ),
        body: Stack(
          children : [
            const Background(),
            Card(
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
                  child: TableCalendar(
                    focusedDay: today,
                    firstDay: DateTime.utc(2000,1,1),
                    lastDay: DateTime.utc(2100,12,31),
                  ),
                ),
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EditSubject1(subjectId: widget.subjectId))
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: 'Edit Subject',
        child: const Icon(Icons.edit),
      ),
    );
  }
}