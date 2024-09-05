import 'package:flutter/widgets.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget JobSummaryWid({jobicon, txt}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Row(
      children: [
        Image(image: AssetImage(jobicon)),
        const SizedBox(
          width: 3,
        ),
        Text(
          txt,
          style: AppTextStyle.normalText,
        )
      ],
    ),
  );
}
