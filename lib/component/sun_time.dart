import 'package:flutter/material.dart';

class SunTime extends StatefulWidget {
  SunTime({
    Key? key,
    required this.imagePath,
    required this.waktoName,
    required this.waktoTime,
    this.color = Colors.black,
  }) : super(key: key);

  final String imagePath;
  final String waktoName;
  final String waktoTime;
  final Color color;

  @override
  State<SunTime> createState() => _SunTime();
}

class _SunTime extends State<SunTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width / 3) - 5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
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
      ),
    );
  }
}
