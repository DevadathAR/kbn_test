import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:intl/intl.dart';

Widget PageAndDate(context,{pageLabel}) {
  Size size = MediaQuery.of(context).size;
  final DateTime now = DateTime.now();
  final DateTime nextMonth = DateTime(now.year, now.month + 1);

  // Formatting dates to 'd-M-yy'
  final String currentMonth = DateFormat('1-MM-yyyy').format(now);
  final String nextMonthStr = DateFormat('1-MM-yyyy').format(nextMonth);

  return SizedBox(
    width: size.width*1,
    height: size.height*.1,
        // color: black,

    child: Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
            pageLabel,
            style: AppTextStyle.googletext,
          ),
          Container(
            // width: 150,
            // height: 40,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image(image: AssetImage(calenderPng)),
                Text(
                  '$currentMonth / $nextMonthStr',
                  style: AppTextStyle.normalText,
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
