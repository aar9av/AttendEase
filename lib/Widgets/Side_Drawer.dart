// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';

import 'Background.dart';
import 'Login_Screen.dart';


class Side_Drawer extends StatefulWidget {
  const Side_Drawer({super.key});

  @override
  State<Side_Drawer> createState() => _Side_DrawerState();
}


class _Side_DrawerState extends State<Side_Drawer> {

  //final ImagePicker _picker = ImagePicker();

  //XFile? profilePicture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topEnd,
            end: AlignmentDirectional.topStart,
            colors: [
              Theme.of(context).primaryColor.withAlpha(200),
              Theme.of(context).primaryColor
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              child: DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RawMaterialButton(
                      onPressed: () async{
                        //final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                        //setState(() {
                          //profilePicture = photo;
                        //});
                      },
                      // child: CircleAvatar(
                      //   radius: 40,
                      //   backgroundImage: (profilePicture==null)?
                      //     const AssetImage("Assets/Images/Profile.png"):
                      //     AssetImage(profilePicture!.path),
                      // ),
                    ),
                    const Text(
                      'Username',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const Text(
                      'abc@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height-230,
              child: Stack(
                children: [
                  const Background(),
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: (){
                      
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Colors.black54,
                                ),
                                Text(
                                  '  Profile',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: (){
                      
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.settings,
                                  size: 30,
                                  color: Colors.black54,
                                ),
                                Text(
                                  '  Settings',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          TextButton(
                            onPressed: (){
                      
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 30,
                                  color: Colors.black54,
                                ),
                                Text(
                                  '  Rate Us',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: (){
                      
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.contact_mail,
                                  size: 30,
                                  color: Colors.black54,
                                ),
                                Text(
                                  '  Contact Us',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: (){
                      
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.share,
                                  size: 30,
                                  color: Colors.black54,
                                ),
                                Text(
                                  '  Share',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const Login_Screen()),
                              );
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.power_settings_new,
                                  size: 30,
                                  color: Colors.black54,
                                ),
                                Text(
                                  '  Logout',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
