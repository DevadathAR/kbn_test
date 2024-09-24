import 'package:flutter/material.dart';
import 'package:kbn_test/newUi/Company/widget/CompanyAndManager.dart';
import 'package:kbn_test/newUi/Company/widget/OtherDetails.dart';
import 'package:kbn_test/newUi/Company/widget/PageAndDate.dart';
import 'package:kbn_test/utilities/colors.dart';

class CompanyProfilePage extends StatelessWidget {
  const CompanyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(height: size.height*0.6222,
      child: ListView(
        children: [
          SizedBox(height: 10,),
          // PageAndDate(context, pageLabel: "Profile"),
          Wrap(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              companyAndManager(context,
                  label: "Company name", sub: "KBN Code", isview: true),
              SizedBox(
                width: size.width * 0.005,
              ),
              companyAndManager(context,
                  label: "Manager name", sub: "Year", isview: true),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Wrap(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
      
                Wrap(children: [companyDetails(
                  context,
                  label: "Compnay Details",
                  sub: "Address",
                ),
                SizedBox(
                  width: size.width * 0.005,
                ),
                otherDetails(
                  context,
                  label: "Team Members",
                ),
                SizedBox(
                  width: size.width * 0.005,
                ),],),
                Wrap(children: [otherDetails(
                  context,
                  label: "Job Positions",
                ),
                SizedBox(
                  width: size.width * 0.005,
                ),
                otherDetails(
                  context,
                  label: "Commmunity",
                ),],)
                
                
              ],
            ),
          )
        ],
      ),
    );
  }
}
