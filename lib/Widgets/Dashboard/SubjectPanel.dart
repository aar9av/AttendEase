import 'package:attend_easy/Functionalities/CloudStore/Attendance.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Add and Edit Subject/EditSubject1.dart';
import '../Start & UI/Background.dart';


class SubjectPanel extends StatefulWidget {
  final String subjectId;
  final String name;

  SubjectPanel({
    Key? key,
    required this.subjectId,
    required this.name,
  }) : super(key: key);

  @override
  State<SubjectPanel> createState() => _SubjectPanelState();
}

class _SubjectPanelState extends State<SubjectPanel> {
  DateTime today = DateTime.now();
  late List<Map<String, dynamic>> attendance = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAttendance();
  }

  Future<void> _fetchAttendance() async {
    print(widget.name);
    List<Map<String, dynamic>> fetchedAttendance = await Attendance.fetchAttendance(widget.subjectId);
    setState(() {
      attendance = fetchedAttendance;
      isLoading = false;
    });
    setState(() {
      for(int i=0; i<attendance.length; i++){
        attendance[i]['dateTime'] = attendance[i]['dateTime'].toDate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
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