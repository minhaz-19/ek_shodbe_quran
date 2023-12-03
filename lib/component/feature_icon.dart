import 'package:flutter/material.dart';

class FeatureIcon extends StatelessWidget {
  const FeatureIcon({
    required this.label,
    required this.iconPath,
    required this.onPressed
  });

  /// Should be inside a column, row or flex widget
  final String label;
  final String iconPath;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(iconPath),
          ),
           Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
