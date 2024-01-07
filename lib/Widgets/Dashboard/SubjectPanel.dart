import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Start & UI/Background.dart';


class SubjectPanel extends StatefulWidget {
  const SubjectPanel({super.key});

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
        )
    );
  }
}