import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget BgWIdget({img, txt = ""}) {
  return Container(
    color: const Color.fromRGBO(217, 217, 217, 1),
    child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, right: 30, bottom: 30),
          child: SizedBox(
            child: Column(
              children: [
                Image(
                  image: AssetImage(img),
                ),
                Text(
                  txt,
                  style: AppTextStyle.bodytextwhite,
                )
              ],
            ),
          ),
        )),
  );
}
