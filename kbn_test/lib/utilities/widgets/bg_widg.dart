import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';

Widget BgWIdget() {
  return Container(
    color: const Color.fromRGBO(217, 217, 217, 1),
    child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(top: 30.0, right: 30,bottom: 30),
          child: Image(image: AssetImage(bg)),
        )),
  );
}
