import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget ErrorPage(x) {
  return Container(
    color: black,
    child:  Center(child: Text(x,style: AppTextStyle.logintext,)),
  );
}
