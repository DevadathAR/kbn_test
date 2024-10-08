import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget shareBTN({required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: tealblue,
          borderRadius: BorderRadius.circular(4),
        ),
        child: SvgPicture.asset(
          shareIcon,
          width: 10,
          height: 10,
          color: white,
        )),
  );
}
