import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ek_shodbe_quran/component/progressbar.dart';
import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:ek_shodbe_quran/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    var userdata = Provider.of<UserDetailsProvider>(context).getName();
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: const Image(
            image: AssetImage(
                'assets/images/toprectangle.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
          foregroundColor: Colors.white,
          title: const Text('প্রোফাইল সম্পাদনা'),
          centerTitle: true,
        ),
        body: (_isLoading)
            ? const ProgressBar()
            : SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      controller: _nameController,
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
                        hintText: userdata == '' ? 'আপনার নাম লিখুন' : userdata,
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
                      onPressed: () async {
                        if (_nameController.text.isNotEmpty) {
                          if (FirebaseAuth.instance.currentUser != null) {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                'name': _nameController.text,
                              }).then((value) {
                                Provider.of<UserDetailsProvider>(context,
                                        listen: false)
                                    .updateName(_nameController.text);
                                Fluttertoast.showToast(
                                    msg: 'হালনাগাদ সম্পন্ন হয়েছে');
                                _nameController.clear();
                              });
                            } on FirebaseAuthException {
                              Fluttertoast.showToast(
                                  msg: 'হালনাগাদ সম্পন্ন হয়নি');
                              setState(() {
                                _isLoading = false;
                              });
                            } catch (e) {
                              Fluttertoast.showToast(
                                  msg: 'হালনাগাদ সম্পন্ন হয়নি');
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                            Fluttertoast.showToast(
                                msg: 'নাম পরিবর্তন করতে লগইন করুন');
                            Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                              builder: (context) => const Login(),
                            ));
                          }
                        } else {
                          Fluttertoast.showToast(msg: 'আপনার নাম লিখুন');
                        }
                      },
                      backgroundcolor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    )
                  ],
                ),
              )));
  }
}
