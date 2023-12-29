import 'package:attend_easy/Widgets/Add%20and%20Edit%20Subject/EditSubject1.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'DashBoardScreen.dart';
import '../Background.dart';
import 'SubjectPanel.dart';


class SubjectsListview extends StatefulWidget {
  const SubjectsListview({super.key});

  @override
  State<SubjectsListview> createState() => _SubjectsListviewState();
}

class _SubjectsListviewState extends State<SubjectsListview> {
  @override
  Widget build(BuildContext context) {
    List<String> subject = ["Subject 1", "Subject 2", "Subject 3", "Subject 4", "Subject 5", "Subject 6", "Subject 7", "Subject 8", "Subject 9", "Subject 10", "Subject 11", "Subject 12"];
    List<String> subjectCoordinator = ["Subject Coordinator 1", "Subject Coordinator 2", "Subject Coordinator 3", "Subject Coordinator 4", "Subject Coordinator 5", "Subject Coordinator 6", "Subject Coordinator 7", "Subject Coordinator 8", "Subject Coordinator 9", "Subject Coordinator 10", "Subject Coordinator 11", "Subject Coordinator 12"];
    List<String> percentage = ["0", "10", "20", "30", "40", "50", "60", "70", "75", "80", "90", "100"];

    return Scaffold(
      body: Stack(
          children: [
            const Background(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: subject.length,
                itemBuilder: (context, index){
                  return Dismissible(
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(20.0),
                        child: const Icon(
                          Icons.delete_rounded,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding:const  EdgeInsets.all(20.0),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                    key: ValueKey<String> (subject[index]),
                    onDismissed: (direction){
                      if(direction == DismissDirection.startToEnd){
                        showDialog<int>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Alert'),
                            content: const Text('Are you sure you want to delete this Subject !!!'),
                            actions: [
                              TextButton(
                                onPressed: (){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const DashBoardScreen())
                                  );
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: (){
                                  final snackBar = SnackBar(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: Colors.white,
                                    content: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'This item is deleted!',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: (){

                                          },
                                          child: Text(
                                            'Undo?',
                                            style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (context) => const DashBoardScreen())
                                  );
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditSubject1()),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: BlurryContainer(
                        color: Colors.black54.withOpacity(0.1),
                        blur: 2,
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SubjectPanel()),
                            );
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.book,
                              size: 40,
                              color: Colors.black.withAlpha(150),
                            ),
                            title: Text(
                              subject[index],
                              style: TextStyle(
                                color: Colors.black.withAlpha(200),
                              ),
                            ),
                            subtitle: Text(
                              subjectCoordinator[index],
                              style: TextStyle(
                                color: Colors.black.withAlpha(200),
                              ),
                            ),
                            trailing: Text(
                              '${percentage[index]}%',
                              style: TextStyle(
                                color: Colors.black.withAlpha(150),
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]
      ),
    );
  }
}