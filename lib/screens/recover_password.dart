
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({super.key});

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? const ProgressBar()
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
                            const SizedBox(
                              height: 20,
                            ),
                            WideButton(
                              'পাসওয়ার্ড পরিবর্তন করুন',
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                if (_emailController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "ইমেইল লিখুন",
                                  );
                                } else {
                                  try {
                                    await FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                            email: _emailController.text)
                                        .then((value) {
                                      Fluttertoast.showToast(
                                          msg:
                                              '${_emailController.text} এ একটি পাসওয়ার্ড পুনরুদ্ধার ইমেল পাঠানো হয়েছে');
                                    });
                                    setState(() {
                                      _emailController.clear();
                                      _isLoading = false;
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
                                }
                              },
                              backgroundcolor: Theme.of(context).primaryColor,
                            )
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
