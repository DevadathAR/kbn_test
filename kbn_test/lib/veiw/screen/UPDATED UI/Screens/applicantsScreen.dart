import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/modelClass.dart';
import 'package:kbn_test/service/singletonData.dart';
import 'package:kbn_test/utilities/lists.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/commonTable.dart';

class CompanyApplicantScreen extends StatefulWidget {
  const CompanyApplicantScreen({super.key});

  @override
  State<CompanyApplicantScreen> createState() => _CompanyApplicantScreenState();
}

class _CompanyApplicantScreenState extends State<CompanyApplicantScreen> {
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
        child: FutureBuilder(
            future: ApiDataService().fetchCompanyData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text("No data available"));
              }
              // Data is successfully fetched
              // Map fetched data to the format required for the table
              Apiresponse companyData = snapshot.data!;
              List<Map<String, String>> pendingApplications = companyData
                  .companyData.applicantsPageData.pending
                  .map((applicantion) {
                return {
                  'date': applicantion.date
                      .toIso8601String(), // Convert DateTime to String
                  'name': applicantion.applicantName,
                  'location': applicantion.location
                      .toString()
                      .split('.')
                      .last, // Convert enum to string
                  'designation': applicantion.designation,
                  'resume': applicantion.resumeLink
                      .toString()
                      .split('.')
                      .last, // Convert enum to string
                  'status': applicantion.status
                      .toString()
                      .split('.')
                      .last, // Convert enum to string
                };
              }).toList();
              List<Map<String, String>> selectedApplications = companyData
                  .companyData.applicantsPageData.selected
                  .map((applicantion) {
                return {
                  // Convert DateTime to String
                  'name': applicantion.name,
                  // Convert enum to string
                  'designation': applicantion.designation,
                  'id': applicantion.applicantId.toString(),
                };
              }).toList();
              return SizedBox(
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
                        data: pendingApplications,
                        statusOptions: ["SELECT", "REJECT"],
                        onStatusChange: (newStatus, applicationId) async {
                          // Handle status change logic specific to this page
                          await ApiServices.updateApplication(
                              newStatus, applicationId);

                          // Update the local job data to reflect the new status
                          setState(() {
                            var applicant = selectedApplications.firstWhere(
                                (application) =>
                                    application['id'] ==
                                    applicationId.toString());
                            applicant['status'] =
                                newStatus; // Update the status locally in the UI
                          });
                        }),
                    const SizedBox(width: 5),
                    selectedApplicantsTable(
                      context,
                      // width:   screenwidth > 600 ? screenwidth * 0.3 : screenwidth,
                      data: isCompany ? selectedApplications : apprvedCompanies,
                      headerTitle:
                          isCompany ? "Selected Applicants" : "To Approve",
                      // currentPath:   path
                    ),
                  ],
                ),
              );
            }));
  }
}
