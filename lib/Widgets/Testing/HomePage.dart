import 'package:flutter/material.dart';
import 'GetUser.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserData userData; // Variable to store user data

  @override
  void initState() {
    super.initState();
    getUserData(); // Fetch user data when the page is initialized
  }

  Future<void> getUserData() async {
    try {
      UserDataService userDataService = UserDataService();
      UserData user = await userDataService.getUserData();

      setState(() {
        userData = user;
      });
    } catch (e) {
      // Handle error
      print('Error getting user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E: ${userData.email}'), // Access email from the variable
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${userData.email}'),
            Text('Password: ${userData.password}'),
          ],
        ),
      ),
    );
  }
}
