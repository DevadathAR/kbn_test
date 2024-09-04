import 'package:flutter/material.dart';

Widget boldText({text, size = 16}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
    ),
  );
}