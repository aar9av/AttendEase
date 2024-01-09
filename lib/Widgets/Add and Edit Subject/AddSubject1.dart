import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Functionalities/Google Map API/Location Picker.dart';
import '../Dashboard/DashBoardScreen.dart';
import 'AddSubject2.dart';
import '../Start & UI/Background.dart';

class AddSubject1 extends StatefulWidget {
  const AddSubject1({super.key});

  @override
  State<AddSubject1> createState() => _AddSubject1State();
}

class _AddSubject1State extends State<AddSubject1> {
  TextEditingController subjectName = TextEditingController();
  TextEditingController subjectCode = TextEditingController();
  TextEditingController subjectCoordinator = TextEditingController();
  double minAttendancePercent = 75;
  LatLng subjectLocation = const LatLng(23.2152, 77.4099);
  bool validateSubjectName = true;

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
      appBar: AppBar(
        title: const Text('Add New Subject'),
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
                          'Subject Info',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        controller: subjectName,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.book),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: 'Subject Name',
                          errorText: validateSubjectName ? null : "Subject name can not be empty!",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        controller: subjectCode,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.book),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: 'Subject Code',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        controller: subjectCoordinator,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: 'Subject Coordinator',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Min Attendance Percentage',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Slider(
                        value: minAttendancePercent,
                        min: 0,
                        max: 100,
                        divisions: 20,
                        label: minAttendancePercent.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            minAttendancePercent = value;
                          });
                        },
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocationPicker(
                                  subjectLocation: subjectLocation,
                                ),
                              ),
                            ).then((selectedLocation) {
                              if (selectedLocation != null) {
                                setState(() {
                                  subjectLocation = selectedLocation;
                                });
                              }
                            });
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 40,
                              ),
                              Text(
                                ' Select Location',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                      const SizedBox(
                        height: 40,
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
                            setState(() {
                              validateSubjectName = subjectName.text.isNotEmpty;
                            });
                            if(validateSubjectName) {
                              // Navigate to the next screen (AddSubject2)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddSubject2(
                                        subjectName: subjectName.text,
                                        subjectCode: subjectCode.text,
                                        subjectCoordinator: subjectCoordinator
                                            .text,
                                        minAttendancePercent: minAttendancePercent
                                            .toInt(),
                                        subjectLocation: subjectLocation,
                                      ),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                            'Cancel',
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
