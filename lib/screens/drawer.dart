import 'package:ek_shodbe_quran/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
            ),
            ListTile(
              leading: const ImageIcon( AssetImage('assets/icons/cart.png')),
              title: const Text(
                "Cart",
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            ListTile(
              leading: const ImageIcon( AssetImage('assets/icons/order.png')),
              title: const Text(
                "Orders",
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            if (FirebaseAuth.instance.currentUser != null)
              ListTile(
                leading: const ImageIcon( AssetImage('assets/icons/editProfile.png')),
                title: const Text(
                  "Profile Update",
                  style: TextStyle(fontSize: 17),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
              ),
            ListTile(
              leading: const ImageIcon( AssetImage('assets/icons/changePassword.png')),
              title: const Text(
                "Change Password",
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            ListTile(
              leading: const ImageIcon( AssetImage('assets/icons/aboutUs.png')),
              title: const Text(
                "About Us",
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            
            
            
            
            FirebaseAuth.instance.currentUser == null
                ? ListTile(
                    leading: const Icon(Icons.login),
                    title: const Text(
                      "Log in",
                      style: TextStyle(fontSize: 17),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  )
                : ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Center(child: Text('Log Out')),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    const Text(
                                      'Do you want to log out?',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'No',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            
                                          },
                                          child: const Text(
                                            'Yes',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

