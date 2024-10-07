import 'package:flutter/material.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/commmonTable.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/scaffoldBuilder.dart';
import 'package:kbn_test/utilities/lists.dart';

class CompanyApplicantScreen extends StatelessWidget {
  const CompanyApplicantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // double screenwidth = size.width;

    // Data for the full table
       final List<Map<String, String>> headers = isCompany
        ? applicantTableheaders
        : companyTableHeaders; // Different headers for company/admin
    final List<Map<String, String>> data =
        isCompany ? applicantsData : companyTableData;

    return ScaffoldBuilder(
      currentPath: "Applicants",
      pageName: "Applicants",
      child: SizedBox(
        height: 420,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              applicantsTable(context,
                  applicantTableheaders,
                  data,
                  ["SELECT", "REGECT"]),
              const SizedBox(width: 5),
              selectedApplicantsTable(context,
              data:   isCompany ? selectedApplicants : apprvedCompanies,
              headerTitle:   isCompany ? "Selected Applicants" : "To Approve",
              ),
            ],
          ),
        ),
      ),
    );
  }
}