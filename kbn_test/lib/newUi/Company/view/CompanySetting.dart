import 'package:flutter/material.dart';
import 'package:kbn_test/newUi/Company/widget/CompaanySettingColum.dart';
import 'package:kbn_test/newUi/Company/widget/CompanyAndManager.dart';
import 'package:kbn_test/newUi/Company/widget/PageAndDate.dart';

class CompanySettingPage extends StatelessWidget {
  const CompanySettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return  Wrap(
          children: [
            PageAndDate(context, pageLabel: "Settings"),
            companyAndManager(context,
                label: "Company name", sub: "KBN Code", isview: false),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Wrap(
                spacing: 16.0, // Set the horizontal space between items
                runSpacing: 16.0, // Set the vertical space between runs
                alignment: WrapAlignment.spaceBetween, // Space items evenly
                children: [
                  companySetting(context,
                      label: "Account",
                      sub: "Email",
                      isItem2view: true,
                      isItem3view: true),
                  companySetting(context,
                      label: "Team Members", sub: "Privacy"),
                  companySetting(context,
                      label: "Job Positions",
                      sub: "Notification",
                      isItem1view: false),
                  companySetting(context, label: "Commmunity", sub: "Language"),
                ],
              ),
            )
          ],
        );
  }
}
