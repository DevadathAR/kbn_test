import 'package:flutter/material.dart';
import 'package:kbn_test/UPDATED%20UI/Screens/profileScreen.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/scaffoldBuilder.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:flutter/material.dart';

class CompanySettingPage extends StatelessWidget {
  const CompanySettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ScaffoldBuilder(
        currentPath: "Settings",
        pageName: "Settings",
        child: SizedBox(
          height: size.height * 0.621,
          child: ListView(
            children: [
              
              SizedBox(
                width: size.width > 1200 ? (size.width - 200) * .49 : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PageAndDate(context, pageLabel: "Settings"),
                    companyAndManager(context,
                        label: "Company name", sub: "KBN Code", isview: false),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Wrap(
                        spacing: 16.0, // Set the horizontal space between items
                        runSpacing: 16.0, // Set the vertical space between runs
                        alignment:
                            WrapAlignment.spaceBetween, // Space items evenly
                        children: [
                          companySetting(context,
                              label: "Account",
                              sub: "Email",
                              isItem2view: true,
                              isItem3view: true),
                          companySetting(context,
                              label: "Security", sub: "Privacy"),
                          companySetting(context,
                              label: "Notification",
                              sub: "Notification",
                              isItem1view: false),
                          companySetting(context,
                              label: "Community", sub: "Language")
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

Widget companySetting(
  BuildContext context, {
  required String label,
  required String sub,
  bool isItem1view = true,
  bool isItem2view = false,
  bool isItem3view = false, // Defaults to true
}) {
  Size size = MediaQuery.of(context).size;
  bool isNotificationEnabled =
      false; // Assuming a variable to track notification state

  return Container(
      width: size.width>1200? (size.width-200)*.24:null,
    height: size.height * 0.5,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      color: white,
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              label,
              style: AppTextStyle.bodytext,
            ),
          ),
          SizedBox(height: size.height * 0.05),

          // Conditionally display based on isItemview
          if (isItem1view)
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  sub,
                  style: AppTextStyle.bodytext,
                ),
              ),
            )
          else
            Wrap(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // alignment: WrapAlignment.spaceEvenly,
              // runSpacing: 40,
              spacing: 100,
              children: [
                const Text(
                  "Enable Notification",
                  style: AppTextStyle.bodytext,
                ),
                Switch(
                  value: isNotificationEnabled,
                  onChanged: (bool newValue) {
                    // Toggle notification state
                    isNotificationEnabled = newValue;
                    // You can use setState or other state management
                  },
                ),
              ],
            ),

          if (isItem2view)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Change Password",
                    style: AppTextStyle.bodytext,
                  ),
                ),
              ),
            ),
          if (isItem3view)
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Add an account",
                  style: AppTextStyle.bodytext,
                ),
              ),
            )
        ],
      ),
    ),
  );
}
