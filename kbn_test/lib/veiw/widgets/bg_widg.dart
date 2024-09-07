import 'package:flutter/material.dart';

Widget BgWIdget({img}) {
  return Container(
    color: const Color.fromRGBO(217, 217, 217, 1),
    child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, right: 30, bottom: 30),
          child: Image(
            image: AssetImage(img),
          ),
        )),
  );
}
