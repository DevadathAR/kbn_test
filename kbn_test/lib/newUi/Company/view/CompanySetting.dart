import 'package:flutter/material.dart';
import 'package:kbn_test/newUi/Company/widget/CompaanySettingColum.dart';
import 'package:kbn_test/newUi/Company/widget/CompanyAndManager.dart';
import 'package:kbn_test/newUi/Company/widget/PageAndDate.dart';

class CompanySettingPage extends StatelessWidget {
  const CompanySettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.621,
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Column(
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
                  alignment: WrapAlignment.spaceBetween, // Space items evenly
                  children: [
                    Wrap(
                      spacing: 16.0, // Set the horizontal space between items
                      runSpacing: 16.0, // Set the vertical space between runs
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        companySetting(context,
                            label: "Account",
                            sub: "Email",
                            isItem2view: true,
                            isItem3view: true),
                        companySetting(context,
                            label: "Team Members", sub: "Privacy"),
                      ],
                    ),
                    Wrap(
                      spacing: 16.0, // Set the horizontal space between items
                      runSpacing: 16.0, // Set the vertical space between runs
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        companySetting(context,
                            label: "Job Positions",
                            sub: "Notification",
                            isItem1view: false),
                        companySetting(context,
                            label: "Commmunity", sub: "Language"),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
