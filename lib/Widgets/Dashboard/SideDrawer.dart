import 'package:attend_easy/Functionalities/Authentication/SignOut.dart';
import 'package:flutter/material.dart';
import '../Background.dart';


class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}


class _SideDrawerState extends State<SideDrawer> {

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
              height: 240,
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              child: const DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("Assets/Images/Profile.png"),
                    ),
                    Text(
                      'Username',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'abc@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height-260,
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
                            onPressed: () async{
                              SignOut().signOutEmail(context);
                              SignOut().signOutGoogle(context);
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