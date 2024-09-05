import 'package:flutter/material.dart';

Widget box({width, height, child, lineWidth = 0.5}) {
  return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black, // Border color
          width: lineWidth, // Border width
        ),
        borderRadius: BorderRadius.circular(1.0), // Optional: Rounded corners
      ),
      child: child);
}
