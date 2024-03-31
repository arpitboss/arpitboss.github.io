import 'package:flutter/material.dart';

Widget buildGridItem(IconData iconData, String text) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: const Color(0xf4f6fbff),
      border: Border.all(color: Colors.blueAccent[100]!, width: 2),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 30,
          color: Colors.blueAccent[200]!,
        ),
        const SizedBox(width: 10),
        Text(text,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent[200]!)),
      ],
    ),
  );
}
