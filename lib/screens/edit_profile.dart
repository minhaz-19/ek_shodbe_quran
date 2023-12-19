import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:ek_shodbe_quran/provider/userDetailsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
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
        body: SingleChildScrollView(
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
                onPressed: () {},
                backgroundcolor: Theme.of(context).primaryColor,
                textColor: Colors.white,
              )
            ],
          ),
        )));
  }
}
