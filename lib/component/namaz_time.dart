import 'package:flutter/material.dart';

class NamazWakto extends StatefulWidget {
  const NamazWakto({
    super.key,
    required this.imagePath,
    required this.waktoName,
    required this.waktoTime,
  });

  final String imagePath;
  final String waktoName;
  final String waktoTime;
  @override
  State<NamazWakto> createState() => _NamazWaktoState();
}

class _NamazWaktoState extends State<NamazWakto> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Column());
  }
}
