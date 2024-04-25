import 'package:flutter/material.dart';

class CircleCategory extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final String image;
  final VoidCallback onTap;

  const CircleCategory(
      {super.key,
      required this.text,
      required this.backgroundColor,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: backgroundColor,
            backgroundImage: AssetImage(image),
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            alignment: Alignment.center,
            width: 75,
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }
}
