import 'package:flutter/cupertino.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget colorDeclaration({required title}) {
  return Row(
    children: [
      Container(
        height: 12,
        width: 12,
        decoration: BoxDecoration(
          color: title == "Previous month" ? tealblue : null,
          borderRadius: BorderRadius.circular(2),
          gradient: title == "Current month" ? gradientColor : null,
        ),
      ),
      const SizedBox(width: 5),
      Text(title, style: AppTextStyle.bodytext),
    ],
  );
}
