import 'dart:core';
import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/companymodelClass.dart';
import 'package:kbn_test/service/singletonData.dart';
import 'package:kbn_test/utilities/lists.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/commonTable.dart';

import '../../../../service/adminMode.dart';

class CompanyApplicantScreen extends StatefulWidget {
  const CompanyApplicantScreen({super.key});

  @override
  State<CompanyApplicantScreen> createState() => _CompanyApplicantScreenState();
}

class _CompanyApplicantScreenState extends State<CompanyApplicantScreen> {
  CompanyApiResponse? _companyData;
  AdminApiResponse? _adminData;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch data when the widget is initialized
  }

  Future<void> _fetchData() async {
    try {
      // ignore: prefer_typing_uninitialized_variables
      var data;
      if (isCompany) {
        data = await ApiDataService().fetchCompanyData();
        setState(() {
          _companyData = data;
          _isLoading = false;
        });
      } else {
        data = await ApiDataService().fetchAdminData();
        setState(() {
          _adminData = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
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
        ? applicantTableheaders //companytable
        : companyTableHeaders; // adminTable

    String path = "Applicants";

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isCompany && _companyData == null) {
      return const Center(child: Text("No company data available"));
    }

    if (!isCompany && _adminData == null) {
      return const Center(child: Text("No admin data available"));
    }

    // Map fetched data to the format required for the table
    List<Map<String, String>> pendingApplications = _companyData
            ?.companyData.applicantsPageData.pending
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
            'id': applicantion.applicationId.toString(),
          };
        }).toList() ??
        [];

    List<Map<String, String>> selectedApplicants =
        _companyData?.companyData.applicantsPageData.selected.map((applicants) {
              return {
                'name': applicants.name,
                'designation': applicants.designation,
                'id': applicants.applicantId.toString(),
              };
            }).toList() ??
            [];

    List<Map<String, String>> companiesToApprove = _adminData
            ?.adminData.companiesPageData.toBeApprovedCompanies
            .map((companies) {
          return {
            'name': companies.companyName,
            'website': companies.website.toString(),
            'id': companies.companyId.toString(),
            
          };
        }).toList() ??
        [];
    List<Map<String, String>> approvedCompanies = _adminData
            ?.adminData.companiesPageData.approvedCompanies
            .map((companies) {
          return {
            'date': companies.date.toIso8601String(),
            'name': companies.companyName,
            'vaccancy': companies.totalVacancy,
            'selected': companies.selected.toString(),
            'kbn': companies.kbnCode,
            'adminStatus': companies.adminStatus,
          };
        }).toList() ??
        [];
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
              Data:isCompany? pendingApplications:approvedCompanies,
              statusOptions: ["SELECT", "REJECT"],
              onStatusChange: () async {
                await _refreshData();
                setState(() {});
              },
            ),
            const SizedBox(width: 5),
            selectedApplicantsTable(
              onAdminAproval: ApiDataService().fetchAdminData,
              context,
              data: isCompany ? selectedApplicants : companiesToApprove,
              headerTitle: isCompany ? "Selected Applicants" : "To Approve",
            ),
          ],
        ),
      ),
    );
  }
}
