import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _oldpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: const Image(
            image: AssetImage(
                'assets/images/toprectangle.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
          foregroundColor: Colors.white,
          title: const Text('পাসওয়ার্ড পরিবর্তন'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 8, 8),
                child: Text(
                  'পুরানো পাসওয়ার্ড',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                controller: _oldpasswordController,
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
                  hintText: 'পুরানো পাসওয়ার্ড',
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
                  'নতুন পাসওয়ার্ড',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                controller: _newpasswordController,
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
                  hintText: 'নতুন পাসওয়ার্ড',
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
                  'পাসওয়ার্ড নিশ্চিত করুন',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                controller: _confirmPasswordController,
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
                  hintText: 'পাসওয়ার্ড নিশ্চিত করুন',
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
                height: 70,
              ),
              WideButton(
                'হালনাগাদ',
                onPressed: () {},
                backgroundcolor: Theme.of(context).primaryColor,
                textColor: Colors.white,
              )
            ],
          ),
        )));
  }
}
