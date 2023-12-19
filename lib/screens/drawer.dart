import 'package:ek_shodbe_quran/screens/home.dart';
import 'package:ek_shodbe_quran/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ek_shodbe_quran/component/dwater_icon.dart';
import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userdata = Provider.of<UserDetailsProvider>(context, listen: false);
    return Drawer(
      child: Column(
        // padding: EdgeInsets.zero,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              image: const DecorationImage(
                  image: AssetImage('assets/images/toprectangle.png'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    userdata.getName() == ''
                        ? 'একশব্দে কুরআন শিক্ষা'
                        : userdata.getName(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Text(
                    userdata.getEmail() == ''
                        ? 'akshobde@gmail.com'
                        : userdata.getEmail(),
                    style: const TextStyle(
                      color: Colors.white,
                      // fontSize: 20,
                    )),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: DrawerIcon(
              image_path: 'assets/icons/cart.png',
            ),
            title: Text(
              'কার্ট',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: DrawerIcon(
              image_path: 'assets/icons/order.png',
            ),
            title: Text(
              'অর্ডার সমূহ',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: DrawerIcon(
              image_path: 'assets/icons/donation.png',
            ),
            title: Text(
              'দান করুন',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: DrawerIcon(
              image_path: 'assets/icons/edit.png',
            ),
            title: Text(
              'প্রোফাইল সম্পাদনা',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20),
            ),
            onTap: () {
              Fluttertoast.showToast(msg: 'প্রোফাইল সম্পাদনা');
            },
          ),
          ListTile(
            leading: DrawerIcon(
              image_path: 'assets/icons/password.png',
            ),
            title: Text(
              'পাসওয়ার্ড পরিবর্তন',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: DrawerIcon(
              image_path: 'assets/icons/aboutus.png',
            ),
            title: Text(
              'আমাদের সম্পর্কে',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20),
            ),
            onTap: () {},
          ),
          FirebaseAuth.instance.currentUser == null
              ? ListTile(
                  leading: DrawerIcon(
                    image_path: 'assets/icons/login.png',
                  ),
                  title: Text(
                    "লগ ইন",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                )
              : ListTile(
                  leading: DrawerIcon(
                    image_path: 'assets/icons/logout.png',
                  ),
                  title: Text(
                    "লগ আউট",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Center(child: Text('লগ আউট')),
                            content: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  const Text(
                                    'আপনি কি লগ আউট করতে চান?',
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
                                          'না',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance
                                              .signOut()
                                              .then((value) {
                                            userdata.updateEmail('');
                                            userdata.updateName('');
                                            userdata.updateId('');
                                          });
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                            (route) => false,
                                          );
                                        },
                                        child: const Text(
                                          'হ্যাঁ',
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
          Spacer(),
          ListTile(
            title: SizedBox(
              height: 50,
              child: Image.asset(
                'assets/images/niharon.png',
                fit: BoxFit.contain,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
