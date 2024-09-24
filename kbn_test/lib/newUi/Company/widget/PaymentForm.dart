import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:kbn_test/newUi/Company/widget/MessagePageCompose.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget paymentFormField(context) {
  Size size = MediaQuery.of(context).size;

  // Get today's date
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('MMM dd, yyyy').format(now);

  return Expanded(
    child: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)), color: white),
      height: size.height * 0.6,
      width: 600,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pay this month"),
            composeForm(text: "Form"),
            composeForm(text: "To"),

            Wrap(
              direction: Axis.horizontal,
              spacing: 40,
              children: [
                paymentDetails(context, header: "Company bank details"),
                paymentDetails(context, header: "Admin bank details")
              ],
            ),

            composeForm(text: "Amount"),
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
                            borderRadius: BorderRadius.circular(
                                10), // Adjust corner radius
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
          ],
        ),
      ),
    ),
  );
}

Widget paymentDetails(context, {header}) {
  Size size = MediaQuery.of(context).size;

  return Container(
    height: 200,
    width: 270,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: black)),
    child: Column(
      // mainAxisAlignment: .start,

      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                header,
                style: const TextStyle(color: semitransp),
              ),
            )),
        morePaymentDetails(label: "Account Number"),
        morePaymentDetails(label: "IFSc code"),
        morePaymentDetails(label: "Branch")
      ],
    ),
  );
}

Widget morePaymentDetails({label}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      height: 30,
      child: TextFormField(
        maxLines: 5,
        decoration: InputDecoration(
          border: InputBorder.none, // Removes the border
          hintText: label, // Assign text directly to labelText for simplicity
        ),
      ),
    ),
  );
}
