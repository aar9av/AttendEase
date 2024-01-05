import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import '../../Functionalities/CloudStore/Subject.dart';
import '../../Background.dart';
import '../../Functionalities/Google Map API/Location Picker.dart';
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
  TextEditingController subjectLocation = TextEditingController();
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
        subjectLocation.text = subjectData['location'] ?? '';
      });
    } catch (e) {
      print('Error fetching subject data: $e');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Edit New Subject')),
      ),
      body: Stack(
        children: [
          const Background(),
          Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: BlurryContainer(
                blur: 5,
                color: Colors.transparent.withOpacity(0.05),
                padding: const EdgeInsets.all(20),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                        divisions: 100,
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
                                MaterialPageRoute<LocationData>(
                                  builder: (context) => LocationPicker(),
                                ),
                              ).then((selectedLocation) {
                                // Handle the selected location (if needed)
                                if (selectedLocation != null) {
                                  setState(() {
                                    subjectLocation.text = "(${selectedLocation.latitude}, ${selectedLocation.longitude})";
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
                              // Navigate to the next screen (AddSubject2)
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
                                        subjectLocation: subjectLocation.text,
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