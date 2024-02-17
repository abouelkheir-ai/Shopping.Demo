import 'package:flutter/material.dart';

class ImageHeader extends StatelessWidget {
  const ImageHeader(
      {super.key,
      required this.icon,
      required this.title,
      required this.color});

  final IconData icon;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
