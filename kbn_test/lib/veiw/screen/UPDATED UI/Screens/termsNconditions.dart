import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';

class TermsNconditions extends StatelessWidget {
  const TermsNconditions({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBuilder(
      currentPath: "Terms",
      pageName: "Terms and Conditions",
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        color: white,
        child: const SingleChildScrollView(
          child: Column(
            children: [
              Text(
                T_n_C_company,
                style: AppTextStyle.fourteenW400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
