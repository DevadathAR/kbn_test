import 'package:flutter/cupertino.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget colorDeclaration({required title}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color: title == "Previous month" ? tealblue : null,
          borderRadius: BorderRadius.circular(2),
          gradient: title == "Current month" ? gradientColor : null,
        ),
      ),
      const SizedBox(width: 3),
      Text(title, style: AppTextStyle.smallText),
    ],
  );
}
