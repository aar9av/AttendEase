import 'package:attend_easy/Background.dart';
import 'package:attend_easy/Functionalities/CloudStore/Users.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final UserData userData;

  const Profile({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController college = TextEditingController();
  TextEditingController course = TextEditingController();
  TextEditingController password = TextEditingController();
  String? preEmail;
  bool validateName = true;
  bool validateEmail = true;
  bool validatePassword = true;
  bool passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {

      setState(() {
        name.text = widget.userData.name;
        email.text = widget.userData.email;
        college.text = widget.userData.college;
        course.text = widget.userData.course;
        password.text = widget.userData.password;
        preEmail = email.text;
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
        title: const Center(child: Text('Edit Profile')),
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
                          'Basic Info',
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
                        controller: name,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          labelText: 'Name',
                          errorText: validateName ? null : "User name can not be empty!",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          labelText: 'Email',
                          errorText: validateEmail ? null : "Email can't be changed!",
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Academic Info',
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
                        controller: college,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.account_balance_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          labelText: 'College',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        controller: course,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.book),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          labelText: 'Course',
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Change Password',
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
                        controller: password,
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.key),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          labelText: 'Password',
                          errorText: validatePassword ? null : "Password must contain at least 8 characters",
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              },);
                            },
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
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              validateName = name.text.isNotEmpty;
                              validateEmail = email.text == preEmail;
                              validatePassword = password.text.length>=8;
                            });
                            if(validateName && validateEmail && validatePassword) {
                              Users.editUser(
                                context,
                                name.text,
                                college.text,
                                course.text,
                                password.text,
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Save',
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
      )
    );
  }
}
