import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Donate extends StatefulWidget {
  const Donate({super.key});

  @override
  State<Donate> createState() => _DonateState();
}

class _DonateState extends State<Donate> {
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
          title: const Text('দান করুন'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'আমাদের সমর্থন দান করুন',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'সূরা দুই, তেত্রিশ নম্বর আয়াতে আল্লাহ বলেন: “আর নামাযে অবিচল থাক; নিয়মিত দাতব্য অনুশীলন; এবং যারা (ইবাদতে) অবনত তাদের সাথে মাথা নত কর”।',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'বিস্তারিত হিসাব:',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'ইসলামী ব্যাংক বিডি লিমিটেড',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.start,
                ),
                const Text(
                  'ব্যাংক A/C: 20502070201564316',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.start,
                ),
                const Text(
                  'রুট নং : 125264639',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.start,
                ),
                const Text(
                  'শাখাঃ উত্তরা, ঢাকা',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      'বিকাশ: ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    const Text(
                      '01715125125',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.start,
                    ),
                    Spacer(),
                    InkWell(
                        onTap: () {
                          // copy to clipboard
                          Clipboard.setData(ClipboardData(text: '01715125125'));
                          Fluttertoast.showToast(
                              msg: "ক্লিপবোর্ডে কপি করা হয়েছে");
                        },
                        child: Icon(Icons.copy)),
                  ],
                ),
                // Row(
                //   children: [
                //     Text(
                //       'নগদ: ',
                //       style: TextStyle(
                //           fontSize: 20,
                //           color: Theme.of(context).primaryColor,
                //           fontWeight: FontWeight.bold),
                //       textAlign: TextAlign.start,
                //     ),
                //     const Text(
                //       '017********',
                //       style: TextStyle(fontSize: 15),
                //       textAlign: TextAlign.start,
                //     ),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Text(
                //       'রকেট: ',
                //       style: TextStyle(
                //           fontSize: 20,
                //           color: Theme.of(context).primaryColor,
                //           fontWeight: FontWeight.bold),
                //       textAlign: TextAlign.start,
                //     ),
                //     const Text(
                //       '017********',
                //       style: TextStyle(fontSize: 15),
                //       textAlign: TextAlign.start,
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ));
  }
}
