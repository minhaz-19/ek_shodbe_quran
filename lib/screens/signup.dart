import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/component/shared_preference.dart';
import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:ek_shodbe_quran/screens/home.dart';
import 'package:ek_shodbe_quran/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameEditingController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isLoading ? ProgressBar(): Stack(
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 8, 8),
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
                          'নাম',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextFormField(
                        controller: _nameEditingController,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        cursorColor: Colors.black54,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 0,
                          ),
                          hintText: 'নাম লিখুন',
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
                            borderSide: const BorderSide(
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
                            borderSide:const  BorderSide(
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
                            borderSide:const  BorderSide(
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
                      const SizedBox(
                        height: 20,
                      ),
                      WideButton(
                        'সাইন আপ',
                        onPressed:  () async {
                          if(_nameEditingController.text.trim().isEmpty){
                            Fluttertoast.showToast(msg: 'নাম লিখুন');
                          }else{
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                            )
                                .then((value) async{
                                  UserDetailsProvider().updateId(value.user!.uid);
                                  await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(value.user!.uid)
                                  .set({
                                'name': _nameEditingController.text,
                                'email': _emailController.text,
                              });
                              UserDetailsProvider().updateName(_nameEditingController.text);
                              UserDetailsProvider().updateEmail(_emailController.text);
                              Fluttertoast.showToast(
                                  msg: 'একাউন্ট সফলভাবে তৈরি হয়েছে');
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                                (Route<dynamic> route) => false,
                              );
                            }).then((value) {
                              saveDataToDevice('email', _emailController.text);
                              saveDataToDevice('password', _passwordController.text);
                            });
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              Fluttertoast.showToast(
                                  msg: 'পাসসওয়ার্ড অনেক সহজ');
                            } else if (e.code == 'email-already-in-use') {
                              Fluttertoast.showToast(
                                  msg:
                                      'সেই ইমেলের জন্য অ্যাকাউন্টটি ইতিমধ্যেই বিদ্যমান');
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
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'একাউন্ট  আছে? ',
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
                                builder: (context) => const Login()));
                      },
                      child: Text(
                        'লগ ইন',
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
