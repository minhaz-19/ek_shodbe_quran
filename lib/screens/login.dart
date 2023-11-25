import 'package:flutter/material.dart';
import 'package:ek_shodbe_quran/component/wide_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
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
                            padding: const EdgeInsets.fromLTRB(0, 15, 8, 8),
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
                        onPressed: () {},
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
                    Text(
                      'সাইন আপ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
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
