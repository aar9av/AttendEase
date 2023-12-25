import 'package:flutter/material.dart';

import 'Add_Subject_1.dart';
import 'Side_Drawer.dart';
import 'Subjects_Listview.dart';


class DashBoard_Screen extends StatelessWidget {
  const DashBoard_Screen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: const Drawer(
          child: Side_Drawer(),
        ),
        appBar: AppBar(
          title: const Text('Hi! User'),
        ),
        body: const Subjects_Listview(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Add_Subject_1())
            );
          },
          tooltip: 'Add Subject',
          child: const Icon(Icons.add),
        ),
    );
  }
}
