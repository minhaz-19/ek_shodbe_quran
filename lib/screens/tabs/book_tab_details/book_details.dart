import 'package:ek_shodbe_quran/component/wide_button.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
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
        title: const Text('তাকওয়ার মহত্ব'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Positioned(
                top: -MediaQuery.of(context).padding.top,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Image.asset(
                      'assets/images/toprectangle.png',
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'তাকওয়ার মহত্ব',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      '350 TK',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            'লেখক : মুহাম্মাদ সালেহ আল মুনাজ্জিদ',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            'প্রকাশনী : ফেরা প্রকাশন',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            'বিষয় : আত্মশুদ্ধি ও অনুপ্রেরণা',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            'অনুবাদক : আরিফ আফ্ফান',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            'পৃষ্ঠা : 72, কভার : পেপার ব্যাক, সংস্করণ : 1st Published, 2022',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            'ভাষা : বাংলা',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'বিস্তারিত',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                            'তোমাদের মধ্যে আল্লাহর নিকট সেই ব্যক্তি সর্বাপেক্ষা মর্যাদাসম্পন্ন, যে তোমাদের মধ্যে সর্বাপেক্ষা মুত্তাকি। নিশ্চয় আল্লাহ সবকিছু জানেন, সকল ব্যাপারে অবহিত।তাকওয়াই হলো শ্রেষ্ঠত্বের উৎস, উত্তম চরিত্রাবলির কেন্দ্রবিন্দু। যেমন দয়া, অঙ্গীকার পূর্ণ করা, সত্যবাদিতা, ন্যায়পরায়ণতা, আত্মসংযম, শরিয়ত নির্দেশিত কাজে ব্যয় করা, দানসদকা, হাদিয়া তথা এ প্রকারের যত উত্তম গুণাবলি রয়েছে, এগুলো তাকওয়া ও আল্লাহভীতিরই শাশ্বত ফলাফল। এই তাকওয়াই মানুষের নির্জনতার একমাত্র সঙ্গী ও ধ্বংস থেকে মুক্তিদানকারী।তোমাদের মধ্যে আল্লাহর নিকট সেই ব্যক্তি সর্বাপেক্ষা মর্যাদাসম্পন্ন, যে তোমাদের মধ্যে সর্বাপেক্ষা মুত্তাকি। নিশ্চয় আল্লাহ সবকিছু জানেন, সকল ব্যাপারে অবহিত।তাকওয়াই হলো শ্রেষ্ঠত্বের উৎস, উত্তম চরিত্রাবলির কেন্দ্রবিন্দু। যেমন দয়া, অঙ্গীকার পূর্ণ করা, সত্যবাদিতা, ন্যায়পরায়ণতা, আত্মসংযম, শরিয়ত নির্দেশিত কাজে ব্যয় করা, দানসদকা, হাদিয়া তথা এ প্রকারের যত উত্তম গুণাবলি রয়েছে, এগুলো তাকওয়া ও আল্লাহভীতিরই শাশ্বত ফলাফল। এই তাকওয়াই মানুষের নির্জনতার একমাত্র সঙ্গী ও ধ্বংস থেকে মুক্তিদানকারী।')
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  WideButton(
                    'কার্ট এ যুক্ত করুন',
                    onPressed: () {},
                    backgroundcolor: Colors.white,
                    textColor: Theme.of(context).primaryColor,
                    borderColor: Theme.of(context).primaryColor,
                    padding: MediaQuery.of(context).size.width * 0.08,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  WideButton(
                    'পড়ে দেখুন',
                    onPressed: () {},
                    backgroundcolor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    padding: MediaQuery.of(context).size.width * 0.08,
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
