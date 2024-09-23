import 'package:flutter/material.dart';
import 'package:kbn_test/newUi/Company/widget/CompanyAndManager.dart';
import 'package:kbn_test/newUi/Company/widget/OtherDetails.dart';
import 'package:kbn_test/newUi/Company/widget/PageAndDate.dart';
import 'package:kbn_test/utilities/colors.dart';

class CompanyProfilePage extends StatelessWidget {
  const CompanyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return 
         Wrap(
          children: [
            PageAndDate(context, pageLabel: "Profile"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                companyAndManager(context, label: "Company name", sub: "KBN Code",isview: true),
                companyAndManager(context, label: "Manager name", sub: "Year",isview: true),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  companyDetails(context,label: "Compnay Details", sub: "Address",),
                  otherDetails(context, label: "Team Members",),
                  otherDetails(context, label: "Job Positions",),
                  otherDetails(context, label: "Commmunity",),
                ],
              ),
            )
          ],
        );
  }
}
