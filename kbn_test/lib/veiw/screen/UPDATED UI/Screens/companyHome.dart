import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/service/adminMode.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/companymodelClass.dart';
import 'package:kbn_test/service/singletonData.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/statisticScreen.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/chartWidget.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/simpleTable.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/verticalTable.dart';

class CompanyHome extends StatefulWidget {
  const CompanyHome({super.key});

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  CompanyApiResponse? companyData;
  AdminApiResponse? adminData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    try {
      if (isCompany) {
        CompanyApiResponse data = await ApiServices.companyData();
        setState(() {
          companyData = data;
          isLoading = false;
        });
      } else {
        AdminApiResponse data = await ApiServices.adminData();
        setState(() {
          adminData = data;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  Future<void> _refreshDataBasedOnRole(bool isCompany) async {
    setState(() {
      isLoading = true; // Set loading state
    });

    if (isCompany) {
      // Fetch company data
      CompanyApiResponse companyData = await ApiServices.companyData();
      companyData = companyData;
    } else {
      // Fetch admin data
      AdminApiResponse adminData = await ApiServices.adminData();
      adminData = adminData;
    }

    setState(() {
      isLoading = false; // Set loading state to false after fetching
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ScaffoldBuilder(
      onMonthSelection: () {
        _refreshDataBasedOnRole(isCompany);
      },
      pageName: "Overview",
      currentPath: "Overview",
      child: SizedBox(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : (isCompany
                ? _buildContent(size, companyData, null)
                : _buildContent(size, null, adminData)),
      ),
    );
  }

  Widget _buildContent(
      Size size, CompanyApiResponse? companyData, AdminApiResponse? adminData) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10.0,
      runSpacing: 10.0,
      children: [
        // First column (Charts and Horizontal Table)
        SizedBox(
          width: size.width > 1200 ? (size.width - 200) * 0.49 : null,
          child: Column(
            children: [
              GestureDetector(
                child: ChartWidget(
                  companyData: companyData?.companyData,
                  adminData: adminData?.adminData,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const CompanyStatisticScreen()));
                },
              ),
              const SizedBox(height: 10),
              HorizontalTable(
                jobsData: companyData?.companyData.jobsPageData,
                approvedCompData:
                    adminData?.adminData.companiesPageData.approvedCompanies,
              ),
            ],
          ),
        ),
        // Second column (Vertical Table)
        SizedBox(
          width: size.width > 1200 ? (size.width - 200) * 0.49 : null,
          child: VerticalTable(
            onAdminAproval: () {
              ApiServices.adminData();
            },
            applicantsData: companyData?.companyData.applicantsPageData,
            toApproveData:
                adminData?.adminData.companiesPageData.toBeApprovedCompanies,
          ),
        ),
      ],
    );
  }
}
