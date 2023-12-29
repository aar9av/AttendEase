import 'package:attend_easy/Widgets/Add%20and%20Edit%20Subject/AddSubject1.dart';
import 'package:attend_easy/Widgets/Dashboard/SideDrawer.dart';
import 'package:flutter/material.dart';
import 'SubjectsListview.dart';


class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: const Drawer(
          child: SideDrawer(),
        ),
        appBar: AppBar(
          title: const Text(
            'Hi! User',
          ),
        ),
        body: const SubjectsListview(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddSubject1())
            );
          },
          backgroundColor: Theme.of(context).primaryColor,
          tooltip: 'Add Subject',
          child: const Icon(Icons.add),
        ),
    );
  }
}
