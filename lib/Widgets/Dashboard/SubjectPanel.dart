import 'package:attend_easy/Functionalities/CloudStore/Attendance.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Add and Edit Subject/EditSubject1.dart';
import '../Start & UI/Background.dart';
import '../../Functionalities/Map & Attendance/TakeAttendanceManually.dart';


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
  late List<DateTime> dates = [];
  late List<String> status = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAttendance();
  }

  Future<void> _fetchAttendance() async {
    List<Map<String, dynamic>> fetchedAttendance = await Attendance.fetchAttendance(widget.subjectId);
    setState(() {
      for(int i=0; i<fetchedAttendance.length; i++){
        dates.add(fetchedAttendance[i]['dateTime'].toDate());
        status.add(fetchedAttendance[i]['status']);
      }
      isLoading = false;
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
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, date, events) {
                          return Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: isCustomDate(date) == 'Present'
                                  ? Colors.green.shade200
                                  : isCustomDate(date) == 'Absent'
                                  ? Colors.red.shade200
                                  : null,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${date.day}',
                                style: TextStyle(
                                  color: isCustomDate(date) == 'Present' || isCustomDate(date) == 'Absent'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                    ),
                    onDaySelected: (selectedDay, focusedDay) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            TakeAttendanceManually(
                              subjectId: widget.subjectId,
                              date: selectedDay, // Use selectedDay instead of focusedDay
                            )
                        ),
                      );
                    },
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

  String isCustomDate(DateTime date) {
    for(int i=0; i<dates.length; i++) {
      if(dates[i].year == date.year && dates[i].month == date.month && dates[i].day == date.day) {
        return status[i];
      }
    }
    return '';
  }

}
