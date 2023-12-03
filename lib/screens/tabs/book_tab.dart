import 'package:ek_shodbe_quran/component/read_book.dart';
import 'package:flutter/material.dart';

class BookTab extends StatefulWidget {
  const BookTab({super.key});

  @override
  State<BookTab> createState() => _BookTabState();
}

class _BookTabState extends State<BookTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(child: ReadBook()),
                Expanded(child: ReadBook()),
                Expanded(
                  child: ReadBook(),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(child: ReadBook()),
                Expanded(child: ReadBook()),
                Expanded(
                  child: ReadBook(),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(child: ReadBook()),
                Expanded(child: ReadBook()),
                Expanded(
                  child: ReadBook(),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(child: ReadBook()),
                Expanded(child: ReadBook()),
                Expanded(
                  child: ReadBook(),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
