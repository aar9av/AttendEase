import 'package:attend_easy/Widgets/Add%20and%20Edit%20Subject/EditSubject2.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import '../Background.dart';


class EditSubject1 extends StatefulWidget {
  const EditSubject1({super.key});

  @override
  State<EditSubject1> createState() => _EditSubject1State();
}

class _EditSubject1State extends State<EditSubject1> {
  double minAttendancePercent = 75;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Edit Subject')),
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
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.book),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          labelText: 'Subject Name',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
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
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Location',
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
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          labelText: 'Location',
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const EditSubject2())
                            );
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