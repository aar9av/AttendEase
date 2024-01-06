import 'package:flutter/material.dart';
import 'package:attend_easy/Widgets/Add%20and%20Edit%20Subject/AddSubject1.dart';
import 'package:attend_easy/Widgets/Dashboard/SideDrawer.dart';
import '../../Functionalities/CloudStore/Users.dart';
import '../Start & UI/LoadingPage.dart';
import 'SubjectsListview.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late UserData userData; // Variable to store user data
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserData(); // Fetch user data when the page is initialized
  }

  Future<void> getUserData() async {
    try {
      Users user = Users();
      UserData userD = await user.getUserData();
      setState(() {
        userData = userD;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      print('Error getting user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return
    isLoading ?
    const Scaffold(
      body: LoadingPage(),
    ):
    Scaffold(
      drawer: Builder(
        builder: (context) => Drawer(
          child: SideDrawer(
              userData: userData,
              context: context
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Hi! ${userData.name}',
        ),
      ),
      body: const SubjectsListview(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushReplacement(
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
