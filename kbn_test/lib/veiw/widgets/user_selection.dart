import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget UserSelection({appuser,colors=none,txtcolor=AppTextStyle.bodytext}) {
  return Padding(
    padding:  const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
    child: Container(
      height: 50,
      width: 130,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)), color: colors),
      child: Center(
          child: Text(
        appuser,
        style: txtcolor,
      )),
    ),
  );
}
Widget SignUpUserSelection({appuser,colors=none,txtcolor=AppTextStyle.bodytext,}) {
  return Padding(
    padding:  const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)), color: colors),
      child: Center(
          child: Text(
        appuser,
        style: txtcolor,
      )),
    ),
  );
}