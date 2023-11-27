import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:ek_shodbe_quran/screens/home.dart';
import 'package:ek_shodbe_quran/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? ProgressBar()
            : Stack(
                children: [
                  Positioned(
                    top: -MediaQuery.of(context).padding.top,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/toprectangle.png',
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                  ),
                  Positioned(
                    top: -MediaQuery.of(context).padding.top,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/icons/applogo.png',
                      height: MediaQuery.of(context).size.height * 0.28,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 8, 8),
                                  child: Text(
                                    'এক শব্দে কুরআন',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 15, 8, 8),
                              child: Text(
                                'ইমেইল',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              cursorColor: Colors.black54,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 0,
                                ),
                                hintText: 'ইমেইল লিখুন',
                                hintStyle: const TextStyle(
                                  color: Colors.black54,
                                ),
                                filled: true,
                                fillColor: Colors.green[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(191, 153, 245, 1),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              onSaved: (newValue) {
                                setState(() {
                                  // Handle the value if needed
                                });
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 15, 8, 8),
                              child: Text(
                                'পাসওয়ার্ড',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              cursorColor: Colors.black54,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 0,
                                ),
                                hintText: 'পাসওয়ার্ড লিখুন',
                                hintStyle: const TextStyle(
                                  color: Colors.black54,
                                ),
                                filled: true,
                                fillColor: Colors.green[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(191, 153, 245, 1),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              onSaved: (newValue) {
                                setState(() {
                                  // Handle the value if needed
                                });
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 15, 8, 8),
                              child: Text(
                                'পাসওয়ার্ড ভুলে গেছেন?',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            WideButton(
                              'লগ ইন',
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  )
                                      .then((value) {
                                        UserDetailsProvider().updateId(value.user!.uid);
                                    FirebaseFirestore.instance
              .collection('admin')
              .doc(value.user!.uid)
              .snapshots()
              .listen(
            (event) {
              final data = event.data() as Map<String, dynamic>;
              UserDetailsProvider().updateName(data['name']);
              UserDetailsProvider().updateEmail(data['email']);
            },
            onError: (error) =>
                Fluttertoast.showToast(msg: "Listen failed: $error"),
          );
                                    Fluttertoast.showToast(
                                        msg: 'একাউন্ট সফলভাবে তৈরি হয়েছে');
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => const Home()),
                                      (Route<dynamic> route) => false,
                                    );
                                  });
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    Fluttertoast.showToast(
                                        msg:
                                            'এই ইমেইল দিয়ে কোন একাউন্ট খুঁজে পাওয়া যায় নি');
                                  } else if (e.code == 'wrong-password') {
                                    Fluttertoast.showToast(
                                        msg: 'ভুল ইমেল বা পাসওয়ার্ড');
                                  }
                                  setState(() {
                                    _isLoading = false;
                                  });
                                } catch (e) {
                                  Fluttertoast.showToast(msg: '$e');
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                              backgroundcolor: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Align the last widget to the center bottom
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'একাউন্ট নেই? ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()));
                            },
                            child: Text(
                              'সাইন আপ',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
