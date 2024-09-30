import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/lists.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/CompanySection/CompanyScaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/commonTable.dart';
import 'package:kbn_test/veiw/widgets_common/boxBTN.dart';
import 'package:kbn_test/veiw/widgets_common/statusUpdate.dart';

class CompanyApplicantScreen extends StatelessWidget {
  const CompanyApplicantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double screenwidth = size.width;

    // Define headers and data for the applicant table based on user type
    final List<Map<String, String>> headers = isCompany
        ? applicantTableheaders
        : companyTableHeaders; // Different headers for company/admin
    final List<Map<String, String>> data =
        isCompany ? applicantsData : companyTableData;

    String path = "Applicants";

    return ScaffoldBuilder(
      currentPath: path,
      pageName: path,
      child: SizedBox(
        height: 420,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              applicantsTable(
                  screenwidth > 600 ? screenwidth * 0.5 : screenwidth,
                  headers,
                  data,
                  ["SELECT", "REGECT"]),
              const SizedBox(width: 5),
              selectedApplicantsTable(
              width:   screenwidth > 600 ? screenwidth * 0.3 : screenwidth,
              data:   isCompany ? selectedApplicants : apprvedCompanies,
              headerTitle:   isCompany ? "Selected Applicants" : "To Approve",
              // currentPath:   path
              ),
            ],
          ),
        ),
      ),
    );
  }
}
