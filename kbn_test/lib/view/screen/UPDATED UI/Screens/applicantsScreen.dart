import 'dart:core';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/companymodelClass.dart';
import 'package:kbn_test/utilities/lists.dart';
import 'package:kbn_test/view/auth/logInPage.dart';
import 'package:kbn_test/view/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/view/screen/UPDATED%20UI/Widgets/commonTable.dart';

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
  DateTime selectedMonth = DateTime.now();

  @override
  void initState() {
    super.initState();

    _fetchData();
    (); // Fetch data when the widget is initialized
  }

  Future<void> _fetchData() async {
    try {
      // ignore: prefer_typing_uninitialized_variables
      var data;
      if (isCompany) {
        // data = await ApiDataService().fetchCompanyData();
        data = await ApiServices.companyData();
        setState(() {
          _companyData = data;
          _isLoading = false;
        });
      } else {
        // data = await ApiDataService().fetchAdminData();
        data = await ApiServices.adminData();

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

  Future<void> _refreshDataBasedOnRole(bool isCompany) async {
    _companyData = null;
    _adminData = null;
    log("refresh");
    setState(() {
      _isLoading = true; // Set loading state
    });

    try {
      if (isCompany) {
        // Fetch company data
        CompanyApiResponse? companyData = await ApiServices.companyData();
        // print(companyData?.companyData.toString());
        _companyData = companyData;
      } else {
        // Fetch admin data
        AdminApiResponse adminData = await ApiServices.adminData();
        _adminData = adminData;
      }
    } catch (e) {}
    setState(() {
      _isLoading = false; // Set loading state to false after fetching
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    // Define headers and data for the applicant table based on user type
    final List<Map<String, String>> headers = isCompany
        ? applicantTableheaders //companytable
        : companyTableHeaders; // adminTable

    String path = "Applicants";
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    String formatDate(DateTime date) {
      return dateFormat.format(date);
    }

    // Map fetched data to the format required for the table
    List<Map<String, String?>> pendingApplications = _companyData == null
        ? []
        : _companyData!.companyData!.applicantsPageData!.pending!
                .map((applicantion) {
              return {
                'date': formatDate(DateTime.parse(
                    applicantion.date!)), // Convert DateTime to String
                'name': applicantion.applicantName,
                'location': applicantion.location.toString().split('.').last,
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

    List<Map<String, String?>> selectedApplicants = _companyData
            ?.companyData!.applicantsPageData!.selected!
            .map((applicants) {
          return {
            'name': applicants.name,
            'designation': applicants.designation,
            'id': applicants.applicantId.toString(),
          };
        }).toList() ??
        [];

    List<Map<String, String?>> companiesToApprove = _adminData
            ?.adminData?.companiesPageData?.toBeApprovedCompanies!
            .map((companies) {
          return {
            'name': companies.companyName,
            'website': companies.website.toString(),
            'id': companies.companyId.toString(),
          };
        }).toList() ??
        [];
    List<Map<String, String?>> approvedCompanies = _adminData
            ?.adminData?.companiesPageData?.approvedCompanies!
            .map((company) {
          return {
            'date': formatDate(DateTime.parse(company.date!)),
            'name': company.companyName,
            'vaccancy': company.totalVacancy,
            'selected': company.selected.toString(),
            'kbn': company.kbnCode?.toString() ?? 'N/A',
            'adminStatus': company.adminStatus,
          };
        }).toList() ??
        [];

    return ScaffoldBuilder(
      onMonthSelection: () {
        // _refreshDataBasedOnRole(isCompany);
        _fetchData();
      },
      currentPath: path,
      pageName: path,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(pendingApplications, context, headers,
              approvedCompanies, selectedApplicants, companiesToApprove),
    );
  }

  SizedBox _buildContent(
      List<Map<String, String?>> pendingApplications,
      BuildContext context,
      List<Map<String, String>> headers,
      List<Map<String, String?>> approvedCompanies,
      List<Map<String, String?>> selectedApplicants,
      List<Map<String, String?>> companiesToApprove) {
    return SizedBox(
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
            Data: isCompany ? pendingApplications : approvedCompanies,
            statusOptions: ["SELECT", "REJECT"],
            onStatusChange: (int applicationId) async {
              _refreshDataBasedOnRole(
                  isCompany); // This will refresh your data after status change
            },
          ),
          const SizedBox(width: 5),
          selectedApplicantsTable(
            onAdminAproval: () async {
              _refreshDataBasedOnRole(isCompany);
            },
            context,
            data: isCompany ? selectedApplicants : companiesToApprove,
            headerTitle: isCompany ? "Selected Applicants" : "To Approve",
          ),
        ],
      ),
    );
  }
}
