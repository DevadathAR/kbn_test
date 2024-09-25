import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget messagePageCompose(context) {
  Size size = MediaQuery.of(context).size;

  // Get today's date
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('MMM dd, yyyy').format(now);

  return Expanded(
    child: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)), color: white),
      height: size.height * 0.65,
    width: size.width < 1200 ? 700 : size.width * 0.4,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: ListView(
          // children: [
          //   Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Compose new"),
                composeForm(text: "Form"),
                composeForm(text: "To"),
                composeForm(text: "Title"),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      border: Border.all(color: black)),
                  child: Column(
                    children: [
                      moreComposeDetails(label: "Wirte your message")
                      ,
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: black),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: TextButton(
                            onPressed: () {}, child: const Text("Upload file")),
                      )
                    ],
                  ),
                ),
                // composeForm(text: "Write your message", lines: 7),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Wrap(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Date: $formattedDate"), // Display today's date
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: 150, // Set the width to 250
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
                            child: const Text(
                              "Send",
                              style: AppTextStyle.flitertxt,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
            //   ],
            // ),
          ],
        ),
      ),
    ),
  );
}

Widget composeForm({
  text,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: TextFormField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: black,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          hintText: text),
    ),
  );
}

Widget moreComposeDetails({label}){
  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      maxLines: 5,
                      decoration:  InputDecoration(
                        border: InputBorder.none, // Removes the border
                        hintText:
                            label, // Assign text directly to labelText for simplicity
                      ),
                    ),
                  );
}