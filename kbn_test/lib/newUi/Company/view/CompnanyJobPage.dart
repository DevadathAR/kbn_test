import 'package:flutter/material.dart';
import 'package:kbn_test/newUi/Company/widget/JobDetailsForm.dart';
import 'package:kbn_test/utilities/colors.dart';

class CompanyJobpage extends StatelessWidget {
  const CompanyJobpage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.687,
      // height: 700,
      child: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 10,
            children: [
              Expanded(
                child: Container(
                  color: black,
                  width: 700,
                  // (size.width-180)*0.49,
                  height: 550,
                ),
              ),
              const jobDetailsForm()
            ],
          )
        ],
      ),
    );
  }
}
