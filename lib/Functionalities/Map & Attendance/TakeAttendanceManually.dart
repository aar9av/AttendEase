// ignore_for_file: use_build_context_synchronously

import 'package:attend_easy/Widgets/Dashboard/DashBoardScreen.dart';
import 'package:attend_easy/Widgets/Start%20&%20UI/Background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../CloudStore/Attendance.dart';

class TakeAttendanceManually extends StatefulWidget {
  final String subjectId;
  final DateTime date;

  TakeAttendanceManually({
    Key? key,
    required this.subjectId,
    required this.date,
  }) : super(key: key);

  @override
  State<TakeAttendanceManually> createState() => _TakeAttendanceManuallyState();
}

class _TakeAttendanceManuallyState extends State<TakeAttendanceManually> {
  List<String> status = ['Present', 'Absent', 'Cancelled'];
  List<String> notation = ['P', 'A', 'C'];
  List<Color> color = [Colors.green.shade300, Colors.red.shade300, Colors.blue.shade300];
  int idx=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark Attendance'),
      ),
      body: Stack(
        children : [
          const Background(),
          SizedBox(
            width: double.infinity,
            height: 150,
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.all(20),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text(
                        "${widget.date.day}/${widget.date.month}/${widget.date.year}",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          idx = (idx + 1) % 3;
                        });
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: color[idx],
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            notation[idx],
                            style: const TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: TextButton(
          onPressed: () async {
            var attendanceData = await Attendance.fetchAttendance(widget.subjectId);
            bool isEntryExist = false;
            for(var attendance in attendanceData){
              DateTime entryDate = (attendance['dateTime'] as Timestamp).toDate();
              if(entryDate.year == widget.date.year && entryDate.month == widget.date.month && entryDate.day == widget.date.day) {
                await Attendance.updateAttendanceDocument(widget.subjectId, attendance['id'], widget.date, status[idx]);
                isEntryExist = true;
              }
            }
            if(!isEntryExist){
              await Attendance.addAttendanceDocument(widget.subjectId, status[idx], widget.date);
            }
            Attendance.resetAttendanceStatus(widget.subjectId);
            const snackBar = SnackBar(
              content: Text(
                'Attendance Marked Successfully!',
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashBoardScreen())
            );
          },
          child: const Text(
            'Save Attendance',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
