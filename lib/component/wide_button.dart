import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  const WideButton(
    this.text, {
    Key? key,
    this.padding = 0.0,
    this.textColor = Colors.black,
    this.height = 45,
    required this.onPressed,
    required this.backgroundcolor,
  }) : super(key: key);

  final String text;
  final double padding;
  final double height;
  final Color backgroundcolor;
  final Color textColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width <= 500
          ? MediaQuery.of(context).size.width
          : 350,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0.0),
            backgroundColor: MaterialStateProperty.all(backgroundcolor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: TextStyle(color: textColor, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
