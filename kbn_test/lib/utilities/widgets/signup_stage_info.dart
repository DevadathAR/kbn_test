import 'package:flutter/material.dart';

Widget StageInfoCircle({infocolor,bordercolor}) {
  return Container(
    height: 10,
    width: 10,
    decoration: BoxDecoration(border: Border.all(color: bordercolor),
        borderRadius: const BorderRadius.all( Radius.circular(10)), color: infocolor),
  );
}
