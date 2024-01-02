import 'package:attend_easy/Background.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class SubjectPanel extends StatefulWidget {
  const SubjectPanel({super.key});

  @override
  State<SubjectPanel> createState() => _SubjectPanelState();
}

class _SubjectPanelState extends State<SubjectPanel> {
  List<String> date = ["Mon, 12 Nov", "Wed, 14 Nov", "Fri, 16 Nov", "Sun, 18 Nov", "Tue, 20 Nov", "Thu, 22 Nov", "Sat, 24 Nov", "Mon, 26 Nov", "Wed, 28 Nov", "Fri, 30 Nov"];
  List<String> attendance = ["Present", "Present", "Absent", "Present", "Present", "Absent", "Present", "Present", "Absent", "Present", "Present", "Absent", "Present", "Present", "Absent", "Present", "Present", "Absent", "Present", "Present"];
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
            Container(
              margin: const EdgeInsets.all(20),
              height: 440,
              child: BlurryContainer(
                blur: 5,
                color: Colors.transparent.withOpacity(0.05),
                padding: const EdgeInsets.all(20),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: TableCalendar(
                  focusedDay: today,
                  firstDay: DateTime.utc(2000,1,1),
                  lastDay: DateTime.utc(2100,12,31),
                ),
              ),
            ),
          ],
        )
    );
  }
}