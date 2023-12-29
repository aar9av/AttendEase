import 'package:attend_easy/Widgets/Dashboard/DashBoardScreen.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import '../Background.dart';


class AddSubject2 extends StatefulWidget {
  const AddSubject2({super.key});

  @override
  State<AddSubject2> createState() => _AddSubject2State();
}

class _AddSubject2State extends State<AddSubject2> {

  Color getColor(Set<MaterialState> states) {
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {

    List<TimeOfDay> time = List.filled(7, TimeOfDay.now());
    List<bool> isChecked = List.filled(7, false);
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
                          itemBuilder: (context, index){
                            return ListTile(
                              leading: Checkbox(
                                checkColor: Theme.of(context).primaryColor,
                                fillColor: MaterialStateProperty.resolveWith(getColor),
                                value: isChecked[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked[index] = value!;
                                  });
                                },
                              ),
                              title: Text(
                                days[index],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              trailing: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(0)),
                                  border: Border(bottom: BorderSide(color: Colors.black),),
                                ),
                                child: TextButton(
                                  onPressed: () async{
                                    final TimeOfDay? inputTime = await showTimePicker(
                                      context: context,
                                      initialTime: time[index],
                                      initialEntryMode: TimePickerEntryMode.dial,
                                    );
                                    if(inputTime != null){
                                      setState(() {
                                        time[index] = inputTime;
                                      });
                                    }
                                  },
                                  child: Text(
                                    "${time[index].hour}:${time[index].minute}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
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
                          onPressed: (){
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const DashBoardScreen())
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
