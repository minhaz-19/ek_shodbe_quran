import 'package:ek_shodbe_quran/screens/tabs/book_tab_details/book_details.dart';
import 'package:flutter/material.dart';

class ReadBook extends StatefulWidget {
  const ReadBook({super.key});
  // final CourseContents coursecontent;
  @override
  State<ReadBook> createState() => _ReadBookState();
}

class _ReadBookState extends State<ReadBook> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .push(MaterialPageRoute(builder: (context) =>  BookDetails(book_name: 'তাকওয়ার মহত্ব', book_image: 'toprectangle', author_name: 'Minhazul Islam', book_price: 14)));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
        width: 250,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Set the desired border radius
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/toprectangle.png'),
                height: 150,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
