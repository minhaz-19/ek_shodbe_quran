import 'package:flutter/material.dart';

class DrawerIcon extends StatelessWidget {
  DrawerIcon({
    super.key,
    required this.image_path,
    required this.onTap,
  });
  void Function() onTap;
  String image_path;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          child: ImageIcon(
            AssetImage(image_path),
            size: 30,
            color: Theme.of(context).primaryColor,
          )),
    );
  }
}
