import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Functionalities/CloudStore/Subject.dart';
import '../Start & UI/Background.dart';
import '../../Functionalities/Map & Attendance/Location Picker.dart';
import 'EditSubject2.dart';


class EditSubject1 extends StatefulWidget {
  final String subjectId;

  EditSubject1({Key? key, required this.subjectId}) : super(key: key);

  @override
  State<EditSubject1> createState() => _EditSubject1State();
}

class _EditSubject1State extends State<EditSubject1> {
  TextEditingController subjectName = TextEditingController();
  TextEditingController subjectCode = TextEditingController();
  TextEditingController subjectCoordinator = TextEditingController();
  double minAttendancePercent = 75;
  LatLng subjectLocation = const LatLng(23.2152, 77.4099);
  bool validateSubjectName = true;

  @override
  void initState() {
    super.initState();
    _fetchSubjectData();
  }

  Future<void> _fetchSubjectData() async {
    try {
      Map<String, dynamic> subjectData =
      await Subject.fetchSubjectData(widget.subjectId);

      setState(() {
        subjectName.text = subjectData['name'] ?? '';
        subjectCode.text = subjectData['code'] ?? '';
        subjectCoordinator.text = subjectData['coordinator'] ?? '';
        minAttendancePercent = (subjectData['minAttendancePercentage'] ?? 75).toDouble();
        subjectLocation = LatLng(subjectData['location'].latitude, subjectData['location'].longitude);
      });
    } catch (e) {
      print('Error fetching subject data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
      appBar: AppBar(
        title: const Text('Edit Subject'),
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
                              borderRadius: BorderRadius.circular(50)
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
                              borderRadius: BorderRadius.circular(50)
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
                              borderRadius: BorderRadius.circular(50)
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
                          onPressed: (){
                            setState(() {
                              validateSubjectName = subjectName.text.isNotEmpty;
                            });
                            if(validateSubjectName) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditSubject2(
                                        subjectId: widget.subjectId,
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
                          onPressed: (){
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