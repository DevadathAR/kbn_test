import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget peoplebgWIdget({img}) {
  return Container(
    color: const Color.fromRGBO(217, 217, 217, 1),
    child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, right: 30, bottom: 30),
          child: Image(image: AssetImage(img)),
        )),
  );
}

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
