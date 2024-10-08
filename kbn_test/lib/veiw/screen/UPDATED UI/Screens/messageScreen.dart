import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kbn_test/service/modelClass.dart';
import 'package:kbn_test/service/singletonData.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/messageDisply.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/showAll_bTn.dart';

class CompanyMessage extends StatelessWidget {
  const CompanyMessage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ScaffoldBuilder(
        currentPath: "Messages",
        pageName: "Messages",
        child: FutureBuilder(
          future: ApiDataService().fetchCompanyData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text("No data available"));
            }
            // Data is successfully fetched
            Apiresponse companyData = snapshot.data!;

            return SizedBox(
              // height: size.height - 200,
              child: Wrap(spacing: 10, runSpacing: 10, children: [
                MessagePageList(
                    messagesPageData:
                        companyData!.companyData.messagesPageData),
                messagePageCompose(context),
              ]),
            );
          },
        ));
  }
}
Widget buildListItem(context,
    {name, description, date, viewreplybutton, imgsize}) {
  Size size = MediaQuery.of(context).size;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(
      children: [
        Image(image: const AssetImage(personPng), height: imgsize),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyle.normalText,
              ),
              const SizedBox(height: 4),
              SizedBox(
                child: Text(
                  description,
                  style: AppTextStyle.twelve_w500,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 16),
        Align(
            alignment: Alignment.topRight,
            child: Text(
              date,style: AppTextStyle.normalText,
            )),
        if (viewreplybutton)
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

Widget messagePageCompose(context) {
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
      // width: size.width < 1200 ? 700 : size.width * 0.4,
      width: size.width > 1200 ? (size.width - 200) * .49 : null,
      // width: null,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
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
                  moreComposeDetails(label: "Wirte your message"),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: black),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                            borderRadius: BorderRadius.circular(
                                10), // Adjust corner radius
                          ),
                        ),
                        child: const Text(
                          "Send",
                          style: AppTextStyle.fifteenW500,
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

Widget composeForm({
  text,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
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

Widget moreComposeDetails({label}) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: TextFormField(
      maxLines: 5,
      decoration: InputDecoration(
        border: InputBorder.none, // Removes the border
        hintText: label, // Assign text directly to labelText for simplicity
      ),
    ),
  );
}
