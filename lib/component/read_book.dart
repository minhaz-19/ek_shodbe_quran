import 'package:ek_shodbe_quran/screens/tabs/book_tab_details/book_details.dart';
import 'package:flutter/material.dart';

class ReadBook extends StatefulWidget {
  const ReadBook(
      {super.key,
      required this.bookName,
      required this.bookImage,
      required this.author,
      required this.prokashok,
      required this.subject,
      required this.translator,
      required this.coverType,
      required this.totalPage,
      required this.bookEdition,
      required this.bookLanguage,
      required this.bookDescription,
      required this.bookPrice});
  // final CourseContents coursecontent;
  final String bookName;
  final String author;
  final String prokashok;
  final String subject;
  final String translator;
  final String coverType;
  final int totalPage;
  final String bookEdition;
  final String bookLanguage;
  final String bookImage;
  final String bookDescription;
  final int bookPrice;
  @override
  State<ReadBook> createState() => _ReadBookState();
}

class _ReadBookState extends State<ReadBook> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (context) => BookDetails(
                  book_name: widget.bookName,
                  book_image: widget.bookImage,
                  author_name: widget.author,
                  book_price: widget.bookPrice,
                  prokashok: widget.prokashok,
                  subject: widget.subject,
                  bookDescription: widget.bookDescription,
                  bookEdition: widget.bookEdition,
                  bookLanguage: widget.bookLanguage,
                  coverType: widget.coverType,
                  totalPage: widget.totalPage,
                  translator: widget.translator,
                )));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
        width: 250,
        height: 400,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Set the desired border radius
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/${widget.bookImage}'),
                height: 300,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.bookName,
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
