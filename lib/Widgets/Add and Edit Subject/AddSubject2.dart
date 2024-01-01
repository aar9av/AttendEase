import 'package:attend_easy/Functionalities/Add%20Data/Add%20Subject.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import '../Background.dart';

class AddSubject2 extends StatefulWidget {
  final subjectName;
  final subjectCode;
  final subjectCoordinator;
  final minAttendancePercent;
  final subjectLocation;

  const AddSubject2({
    Key? key,
    required this.subjectName,
    required this.subjectCode,
    required this.subjectCoordinator,
    required this.minAttendancePercent,
    required this.subjectLocation,
  }) : super(key: key);

  @override
  State<AddSubject2> createState() => _AddSubject2State();
}

class TimeSlot {
  bool isChecked;
  TimeOfDay time;

  TimeSlot({required this.isChecked, required this.time});
}

class _AddSubject2State extends State<AddSubject2> {
  List<TimeSlot> timeSlots = List.generate(
    7,
        (index) => TimeSlot(isChecked: false, time: TimeOfDay.now()),
  );

  Color getColor(Set<MaterialState> states) {
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add New Subject')),
      ),
      body: Stack(
        children: [
          const Background(),
          Center(
            child: SingleChildScrollView(
              child: Container(
                height: 650,
                margin: const EdgeInsets.all(30.0),
                child: BlurryContainer(
                  blur: 5,
                  color: Colors.transparent.withOpacity(0.05),
                  padding: const EdgeInsets.all(20),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Time Table',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 400,
                        child: ListView.separated(
                          itemCount: 7,
                          separatorBuilder: (context, index) => const SizedBox(height: 0),
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Checkbox(
                                checkColor: Theme.of(context).primaryColor,
                                fillColor: MaterialStateProperty.resolveWith(getColor),
                                value: timeSlots[index].isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    timeSlots[index].isChecked = value!;
                                  });
                                },
                              ),
                              title: Text(
                                days[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: timeSlots[index].isChecked ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              trailing: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(0)),
                                  border: Border(bottom: BorderSide(color: Colors.black),),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    if (timeSlots[index].isChecked) {
                                      final TimeOfDay? inputTime = await showTimePicker(
                                        context: context,
                                        initialTime: timeSlots[index].time,
                                        initialEntryMode: TimePickerEntryMode.dial,
                                      );
                                      if (inputTime != null) {
                                        setState(() {
                                          timeSlots[index].time = inputTime;
                                        });
                                      }
                                    }
                                  },
                                  child: Text(
                                    timeSlots[index].isChecked
                                        ? "${timeSlots[index].time.hour}:${timeSlots[index].time.minute}"
                                        : 'Select',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: timeSlots[index].isChecked ? Colors.black : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            AddSubject.addSubject(
                              context,
                              widget.subjectName,
                              widget.subjectCode,
                              widget.subjectCoordinator,
                              widget.minAttendancePercent,
                              widget.subjectLocation,
                              timeSlots,
                            );
                          },
                          child: const Text(
                            'Add Subject',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Previous',
                            style: TextStyle(
                              color: Colors.black,
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
