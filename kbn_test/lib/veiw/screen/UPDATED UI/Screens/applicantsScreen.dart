import 'package:flutter/material.dart';
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
  late Apiresponse? _companyData;
  bool _isLoading = true; // Loading state to track data fetching

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch data when the widget is initialized
  }

  Future<void> _fetchData() async {
    try {
      _companyData = await ApiDataService().fetchCompanyData();
      setState(() {
        _isLoading = false; // Data loaded
      });
    } catch (error) {
      // Handle error (show message, etc.)
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true; // Set loading state
    });
    await ApiDataService().fetchCompanyData(); // Re-fetch data
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Define headers and data for the applicant table based on user type
    final List<Map<String, String>> headers = isCompany
        ? applicantTableheaders
        : companyTableHeaders; // Different headers for company/admin

    String path = "Applicants";

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_companyData == null) {
      return const Center(child: Text("No data available"));
    }

    // Map fetched data to the format required for the table
    List<Map<String, String>> pendingApplications = _companyData!
        .companyData.applicantsPageData.pending
        .map((applicantion) {
      return {
        'date':
            applicantion.date.toIso8601String(), // Convert DateTime to String
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
        'id': applicantion.applicationId.toString()
      };
    }).toList();

    List<Map<String, String>> selectedApplicants =
        _companyData!.companyData.applicantsPageData.selected.map((applicants) {
      return {
        // Convert DateTime to String
        'name': applicants.name,
        // Convert enum to string
        'designation': applicants.designation,
        'id': applicants.applicantId.toString(),
      };
    }).toList();

    return ScaffoldBuilder(
      currentPath: path,
      pageName: path,
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: [
            applicantsTable(
              status: pendingApplications.isNotEmpty
                  ? pendingApplications[0]['status'].toString()
                  : '',
              context: context,
              headers: headers,
              data: pendingApplications,
              statusOptions: ["SELECT", "REJECT"],
              onStatusChange: () async {
                await _refreshData();
                setState(() {});
              },
            ),
            const SizedBox(width: 5),
            selectedApplicantsTable(
              context,
              data: isCompany ? selectedApplicants : apprvedCompanies,
              headerTitle: isCompany ? "Selected Applicants" : "To Approve",
            ),
          ],
        ),
      ),
    );
  }
}