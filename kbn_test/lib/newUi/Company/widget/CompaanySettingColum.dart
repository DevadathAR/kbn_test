import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget companySetting(
  BuildContext context, {
  required String label,
  required String sub,
  bool isItem1view = true,
  bool isItem2view = false, 
  bool isItem3view = false, // Defaults to true
}) {
  Size size = MediaQuery.of(context).size;
  bool isNotificationEnabled = false; // Assuming a variable to track notification state

  return Container(
    // width: size.width < 1200 ? 170 : size.width * 0.198,
    // height: size.height * 0.5,

    width: 340,
    height: 400,
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
              style: AppTextStyle.subheadertext,
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
                  style: AppTextStyle.normalHeading,
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
                  style: AppTextStyle.normalHeading,
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
                    style: AppTextStyle.normalHeading,
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
                  style: AppTextStyle.normalHeading,
                ),
              ),
            )
        ],
      ),
    ),
  );
}
