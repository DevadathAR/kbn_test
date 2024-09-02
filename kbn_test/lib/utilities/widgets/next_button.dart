import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget NextButton(BuildContext context, {Color? buttoncolor, String? text, Widget? nextpage, Function()? onPressed}) {
  return GestureDetector(
    onTap: () {
      if (onPressed != null) {
        onPressed();
      } else if (nextpage != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return nextpage;
        }));
      }
    },
    child: Container(
      height: 33,
      width: 119,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
          color: buttoncolor,
          border: Border.all(color: black)),
      child: Center(
          child: Text(
        text!,
        style: AppTextStyle.subheadertext,
      )),
    ),
  );
}