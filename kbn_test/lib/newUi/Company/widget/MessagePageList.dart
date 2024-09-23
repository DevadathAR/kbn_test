import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget messagePageList(context) {
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
                child: buildListItem(context,
                    name: "name", description: "description", date: "date")),
          );
        },
      ),
    ),
  );
}

Widget buildListItem(context, {name, description, date}) {
  Size size = MediaQuery.of(context).size;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(
      children: [
        const Image(image: AssetImage(personPng), height: 60),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
        const SizedBox(width: 16),
        Align(
            alignment: Alignment.topRight,
            child: Text(
              date,
            )),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 10),
            child: SizedBox(
              width: 100,
              height: 30,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: tealblue,
                  shape: RoundedRectangleBorder(
                    // Creates rounded corner buttons
                    borderRadius:
                        BorderRadius.circular(10), // Adjust corner radius
                  ),
                ),
                child: const Expanded(
                  child: Text(
                    "Replay",
                    style: TextStyle(color: white),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
