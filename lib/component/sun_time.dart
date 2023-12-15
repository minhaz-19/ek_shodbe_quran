import 'package:flutter/material.dart';

class SunTime extends StatefulWidget {
  SunTime({
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
  State<SunTime> createState() => _SunTimeState();
}

class _SunTimeState extends State<SunTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 127,
        width: 194,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.imagePath),
              // fit: BoxFit.cover,
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
                        color: Colors.white,
                        fontSize: 20,
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
            Row(
              children: [
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
            ),
          ],
        ));
  }
}
