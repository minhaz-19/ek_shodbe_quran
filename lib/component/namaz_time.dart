import 'package:flutter/material.dart';

class NamazWakto extends StatefulWidget {
  NamazWakto({
    super.key,
    required this.imagePath,
    required this.waktoName,
    required this.waktoTime,
    this.color = Colors.black,
  });

  final String imagePath;
  final String waktoName;
  final String waktoTime;
  var color;
  @override
  State<NamazWakto> createState() => _NamazWaktoState();
}

class _NamazWaktoState extends State<NamazWakto> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(11),
              child: Row(
                children: [
                  Text(
                    widget.waktoName,
                    style: TextStyle(
                        color: widget.color,
                        fontSize: (widget.waktoName == 'তাহাজ্জুদ') ? 15 : 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  ImageIcon(
                    AssetImage(
                      'assets/icons/alarm.png',
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(11),
              child: Text(
                widget.waktoTime,
                style: TextStyle(
                  color: widget.color,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ));
  }
}
