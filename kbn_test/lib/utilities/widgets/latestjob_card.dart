import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/utilities/widgets/error.dart';

Widget LatestJobCard(context) {
  return Padding(
    padding: const EdgeInsets.only(right: 10, bottom: 20),
    child: Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: black,
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("logo"),
                Column(
                  children: [
                    Text("position"),
                    Text("name"),
                  ],
                ),
                Image(
                  image: AssetImage(likePng),
                  color: black,
                )
              ],
            ),
          ),
          Container(
            color: yellow,
            child: const Text("content fromm api"),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                JobCardButtons(context, label: "Senior Level"),
                JobCardButtons(context, label: "On-Site"),
                JobCardButtons(context, label: "Full time"),
              ],
            ),
          ),
          const Divider(),
          Container(
              child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("salary"), Text("posted date")],
          )),
        ],
      ),
    ),
  );
}

Widget JobCardButtons(context, {label}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ErrorPage("next page");
        },
      ));
    },
    child: Container(
      height: 15,
      width: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: green,
      ),
      child: Center(
          child: Text(
        label,
        style: AppTextStyle.buttontxt,
      )),
    ),
  );
}
