import 'package:attend_easy/Widgets/Background.dart';
import 'package:attend_easy/Widgets/Dashboard/DashBoardScreen.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';



class EditSubject2 extends StatefulWidget {
  const EditSubject2({super.key});

  @override
  State<EditSubject2> createState() => _EditSubject2State();
}

class _EditSubject2State extends State<EditSubject2> {
  bool isCheckedAllDays = false;
  bool isCheckedSameTime = false;
  List<String> time = ["1", "2", "3", "4", "5", "6", "7"];
  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];


  @override
  Widget build(BuildContext context) {

    Color getColor(Set<MaterialState> states) {
      return Colors.white;
    }

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
                          'Time Table',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  'M',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  'T',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  'W',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  'T',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  'F',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade400,
                              ),
                              child: Center(
                                child: Text(
                                  'S',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade400,
                              ),
                              child: Center(
                                child: Text(
                                  'S',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            checkColor: Theme.of(context).primaryColor,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: isCheckedAllDays,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedAllDays = value!;
                              });
                            },
                          ),
                          const Text(
                            'Select All',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            checkColor: Theme.of(context).primaryColor,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: isCheckedSameTime,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedSameTime = value!;
                              });
                            },
                          ),
                          const Text(
                            'Set same time for all selected days.',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: SizedBox(
                          height: 60,
                          child: Center(
                            child: Text(
                              'Common Time',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 240,
                        child: ListView.builder(
                          itemCount: days.length,
                          itemBuilder: (context, index){
                            return ListTile(
                              title: Text(
                                days[index],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              trailing: const SizedBox(
                                width: 100,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: '00:00',
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
                          onPressed: (){
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const DashBoardScreen())
                            );
                          },
                          child: const Text(
                            'Edit Subject',
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
                          onPressed: (){
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
