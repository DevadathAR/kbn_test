import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/lists.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/commonTable.dart';

class CompanyApplicantScreen extends StatelessWidget {
  const CompanyApplicantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // double screenwidth = size.width;

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
        // height: 420,
        width: double.infinity,
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: [
            applicantsTable(
              context: context,
              // screenwidth > 600 ? screenwidth * 0.5 : screenwidth,
              headers: headers,
              data: data,
              statusOptions: ["SELECT", "REGECT"],

              onStatusChange: (newStatus, applicationId) {
                // Handle status change logic specific to this page
                print(
                    "Status changed to $newStatus for application $applicationId");
                // Example: Call API to update the status
                ApiServices.updateApplication(newStatus, applicationId);
              },
            ),
            const SizedBox(width: 5),
            selectedApplicantsTable(
              context,
              // width:   screenwidth > 600 ? screenwidth * 0.3 : screenwidth,
              data: isCompany ? selectedApplicants : apprvedCompanies,
              headerTitle: isCompany ? "Selected Applicants" : "To Approve",
              // currentPath:   path
            ),
          ],
        ),
      ),
    );
  }
}
