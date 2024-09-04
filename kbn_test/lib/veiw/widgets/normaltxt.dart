import 'package:flutter/material.dart';

Widget normalText({text}) {
  return Text(
    text,
    style: const TextStyle(fontSize: 10),
    maxLines: 10,
    overflow: TextOverflow.ellipsis,
  );
}