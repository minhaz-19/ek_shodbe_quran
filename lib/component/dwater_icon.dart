import 'package:flutter/material.dart';

class DrawerIcon extends StatelessWidget {
  DrawerIcon({
    super.key,
    required this.image_path,
  });
  String image_path;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ImageIcon(
          AssetImage(image_path),
          size: 25,
          color: Theme.of(context).primaryColor,
        ));
  }
}
