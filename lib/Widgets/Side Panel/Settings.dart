import 'package:attend_easy/Background.dart';
import 'package:attend_easy/Widgets/Login%20and%20Signup/LoginScreen.dart';
import 'package:flutter/material.dart';
import '../../Functionalities/CloudStore/Users.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings')
      ),
      body: const Stack(
        children: [
          Background(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: TextButton(
          onPressed: () {
            showDialog<int> (
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Alert'),
                content: const Text('Are you sure you want to delete this Account?'),
                actions: [
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Users.deleteUser();
                      Users.deleteUserAuth();
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
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
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          child: const Text(
            'Delete Account',
            style: TextStyle(
              fontSize: 24,
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
