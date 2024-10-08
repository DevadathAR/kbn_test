import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/profileScreen.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';

class CompanySettingPage extends StatefulWidget {
  const CompanySettingPage({super.key});

  @override
  _CompanySettingPageState createState() => _CompanySettingPageState();
}

class _CompanySettingPageState extends State<CompanySettingPage> {
  String? selectedSetting; // Track which mobScreenSetting is tapped

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ScaffoldBuilder(
      currentPath: "Settings",
      pageName: "Settings",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: size.width > 1200 ? (size.width - 200) * .49 : null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                companyAndManager(context,
                    label: "Company name", sub: "KBN Code", isview: false),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: size.width > 900
                      ? Wrap(
                          spacing:
                              16.0, // Set the horizontal space between items
                          runSpacing:
                              16.0, // Set the vertical space between runs
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
                                label: "General", sub: "Language"),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Conditionally render companySetting or mobScreenSettings based on selection
                            selectedSetting == "Account"
                                ? companySetting(
                                    context,
                                    label: "Account",
                                    sub: "Email",
                                    isItem2view: true,
                                    isItem3view: true,
                                  )
                                : mobScreenSettings(
                                    context,
                                    text: "Account",
                                    onTap: () {
                                      setState(() {
                                        selectedSetting = "Account";
                                      });
                                    },
                                  ),
                            selectedSetting == "Security"
                                ? companySetting(
                                    context,
                                    label: "Security",
                                    sub: "Privacy",
                                  )
                                : mobScreenSettings(
                                    context,
                                    text: "Security",
                                    onTap: () {
                                      setState(() {
                                        selectedSetting = "Security";
                                      });
                                    },
                                  ),
                            selectedSetting == "Notification"
                                ? companySetting(
                                    context,
                                    label: "Notification",
                                    sub: "Notification",
                                    isItem1view: false,
                                  )
                                : mobScreenSettings(
                                    context,
                                    text: "Notification",
                                    onTap: () {
                                      setState(() {
                                        selectedSetting = "Notification";
                                      });
                                    },
                                  ),
                            selectedSetting == "General"
                                ? companySetting(
                                    context,
                                    label: "General",
                                    sub: "Language",
                                  )
                                : mobScreenSettings(
                                    context,
                                    text: "General",
                                    onTap: () {
                                      setState(() {
                                        selectedSetting = "General";
                                      });
                                    },
                                  ),
                          ],
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
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
    // width: size.width >     1200 ? size.width * 0.198  : size.width > 900 ? 170: null,
    width: size.width > 900 ? (size.width - 225) * 0.24 : null,

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
              style: AppTextStyle.bodytext_12,
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
                  style: AppTextStyle.bodytext_12,
                ),
              ),
            )
          else
            Wrap(
              spacing: 100,
              children: [
                const Text(
                  "Enable Notification",
                  style: AppTextStyle.bodytext_12,
                ),
                Switch(
                  value: isNotificationEnabled,
                  onChanged: (bool newValue) {
                    isNotificationEnabled = newValue;
                    // Handle state management or logic when the switch is toggled
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
                    style: AppTextStyle.bodytext_12,
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
                  style: AppTextStyle.bodytext_12,
                ),
              ),
            )
        ],
      ),
    ),
  );
}

Widget mobScreenSettings(BuildContext context,
    {required String text, required VoidCallback onTap}) {
  Size size = MediaQuery.of(context).size;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 30),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)), color: white),
        height: 35,
        width: size.width * 1,
        child: Text(
          text,
          style: AppTextStyle.normalText,
        ),
      ),
    ),
  );
}
