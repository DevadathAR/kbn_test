import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kbn_test/UPDATED%20UI/Screens/messageScreen.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/scaffoldBuilder.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

class CompanyTransation extends StatelessWidget {
  const CompanyTransation({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ScaffoldBuilder(
      currentPath: "Transactions",
      pageName: "Transaction",
      child: size.height > 300
          ? SizedBox(
              height: size.height - 300,
              child: SingleChildScrollView(
                child: Wrap(spacing: 10, runSpacing: 10, children: [
                  transationPageList(context),
                  paymentFormField(context)
                ]),
              ),
            )
          : Container(),
    );
  }
}

Widget transationPageList(context) {
  Size size = MediaQuery.of(context).size;

  return Container(
    // height: size.height * 0.2,
    height: 500,
    // height: size.height - 300,

    // width: 600,
                width: size.width > 1200 ? (size.width -200)* .49: null,

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
        const Image(image: AssetImage(kbnLogo), height: 20),
        const SizedBox(width: 16),
        const Text("Date"),
        const Text("Amount"),
        const Text("Account Number"),
        const Text("Mail ID"),
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: tealblue),
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
              child: const Text(
                "Download",
                style: AppTextStyle.applytxt,
              )),
        )
      ],
    ),
  );
}

Widget paymentFormField(context) {
  Size size = MediaQuery.of(context).size;

  // Get today's date
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('MMM dd, yyyy').format(now);

  return Expanded(
    child: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)), color: white),
      // height: size.height * 0.6,
      height: 500,
      // height: size.height - 300,

      // width: 600,
                width: size.width > 1200 ? (size.width -200)* .49: null,

      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: ListView(
          children: [
            Column(
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
                        child: Text(
                            "Date: $formattedDate"), // Display today's date
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
                                    8), // Adjust corner radius
                              ),
                            ),
                            child: const Text(
                              "Pay",
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
