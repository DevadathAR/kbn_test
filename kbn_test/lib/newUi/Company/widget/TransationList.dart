import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget transationPageList(context) {
  Size size = MediaQuery.of(context).size;

  return Container(
    height: size.height * 0.6,
    width: 600,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)), color: white),
    child: Scrollbar(
      thumbVisibility: true,
      trackVisibility: true,
      scrollbarOrientation: ScrollbarOrientation.right,
      interactive: true,
      thickness: 10,
      radius: const Radius.circular(6),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: black),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    color: white),
                height: 100,
                child: transationListItem(
                  context,
                )),
          );
        },
      ),
    ),
  );
}

Widget transationListItem(context, {name, description, date}) {
  Size size = MediaQuery.of(context).size;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Image(image: const AssetImage(kbnLogo), height: 20),
        const SizedBox(width: 16),
        const Text("Date"),
        const Text("Amount"),
        const Text("Account Number"),
        const Text("Mail ID"),
        Container(decoration: const BoxDecoration(borderRadius:  BorderRadius.all(Radius.circular(8)),color: tealblue),
          height: 30,
          width: 100,
          child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Container();
                  },
                ));
              },
              child: const Text("Download",style: AppTextStyle.applytxt,)),
        )
      ],
    ),
  );
}
