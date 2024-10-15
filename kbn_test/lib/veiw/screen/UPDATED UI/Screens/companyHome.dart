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
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  // Function to fetch data from the singleton service based on the role
  void _fetchData() async {
    try {
      // ignore: prefer_typing_uninitialized_variables
      var data;
      // print(isCompany);
      if (isCompany) {
        // data = await ApiDataService().fetchCompanyData();
        data = await ApiServices.companyData();

        setState(() {
          companyData = data;
          isLoading = false;
        });
      } else {
        // Fetch admin data if the role is 'Admin'
        // data = await ApiDataService().fetchAdminData();
        data = await ApiServices.adminData();
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isCompany) {
      if (companyData == null) {
        return const Center(child: Text("No CompanyData*home available"));
      }
    } else {
      if (adminData == null) {
        return const Center(child: Text("No Admin Data *home available"));
      }
    }

    return ScaffoldBuilder(
      pageName: "Overview",
      currentPath: "Overview",
      child: SizedBox(
        // height: 410,
        child: Wrap(
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
                      companyData: isCompany
                          ? companyData?.companyData
                          : null, // Changed to null-aware
                      adminData: !isCompany
                          ? adminData?.adminData
                          : null, // Changed to null-aware
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CompanyStatisticScreen()));
                    },
                  ), // Pass data here
                  const SizedBox(height: 10),
                  HorizontalTable(
                    jobsData: isCompany
                        ? companyData?.companyData.jobsPageData
                        : null,
                    // if user is not company
                    approvedCompData: !isCompany
                        ? adminData
                            ?.adminData.companiesPageData.approvedCompanies
                        : null,
                  ), // Pass data here
                ],
              ),
            ),

            // Second column (Vertical Table)
            SizedBox(
              width: size.width > 1200
                  ? (size.width - 200) * 0.49
                  : null, // Adjust the width as necessary
              child: VerticalTable(
                onAdminAproval: () {
                  // ApiDataService().fetchCompanyData();
                  ApiServices.companyData();
                },
                applicantsData: isCompany
                    ? companyData?.companyData.applicantsPageData
                    : null,
                // if user is not company
                toApproveData: !isCompany
                    ? adminData
                        ?.adminData.companiesPageData.toBeApprovedCompanies
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
