import 'package:ek_shodbe_quran/component/admin/admin.dart';
import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:ek_shodbe_quran/provider/cartProvider.dart';
import 'package:ek_shodbe_quran/screens/aboutUs.dart';
import 'package:ek_shodbe_quran/screens/cart.dart';
import 'package:ek_shodbe_quran/screens/change_password.dart';
import 'package:ek_shodbe_quran/screens/edit_profile.dart';
import 'package:ek_shodbe_quran/screens/home.dart';
import 'package:ek_shodbe_quran/screens/login.dart';
import 'package:ek_shodbe_quran/screens/order_list_page.dart';
import 'package:ek_shodbe_quran/screens/tabs/home_tab_details/donate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ek_shodbe_quran/component/dwater_icon.dart';
import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userdata = Provider.of<UserDetailsProvider>(context, listen: false);
    var cartDetails = Provider.of<CartProvider>(context);
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
          (UserDetailsProvider().getRole() == 'admin')
              ? ListTile(
                  leading: DrawerIcon(
                    image_path: 'assets/icons/admin.png',
                  ),
                  title: Text(
                    'অ্যাডমিন প্যানেল',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                  ),
                  onTap: () async {
                    if (cartDetails.bookList.length == 0) {
                      await cartDetails.initializeFromSharedPreferences();
                    }

                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const admin()),
                    );
                  },
                )
              : const SizedBox(),
          ListTile(
            leading: DrawerIcon(
              image_path: 'assets/icons/cart.png',
            ),
            title: Text(
              'কার্ট',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20),
            ),
            onTap: () async {
              if (cartDetails.bookList.length == 0) {
                await cartDetails.initializeFromSharedPreferences();
              }

              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Cart()),
              );
            },
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
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderList()),
              );
            },
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
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Donate()),
              );
            },
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
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfile()),
              );
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
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChangePassword()),
              );
            },
          ),
          ListTile(
            leading: DrawerIcon(
              image_path: 'assets/icons/aboutUs.png',
            ),
            title: Text(
              'আমাদের সম্পর্কে',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUs()),
              );
            },
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
                                        child: Text(
                                          'না',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance
                                              .signOut()
                                              .then((value) async {
                                            userdata.updateEmail('');
                                            userdata.updateName('');
                                            userdata.updateId('');
                                            await removeDataFromDevice('email');
                                            await removeDataFromDevice(
                                                'password');
                                          });
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                            (route) => false,
                                          );
                                        },
                                        child: Text(
                                          'হ্যাঁ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor),
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
            onTap: () async {
              await _launchURL('https://niharon.com/');
            },
          ),
        ],
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    Fluttertoast.showToast(msg: 'Could not launch $url');
    throw 'Could not launch $url';
  }
}
