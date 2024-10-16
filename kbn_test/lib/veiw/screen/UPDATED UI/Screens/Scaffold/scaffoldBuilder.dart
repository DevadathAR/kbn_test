import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/service/adminMode.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/companymodelClass.dart';

import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/drawer.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/horizontalCardList.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/page_and_date.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/sidebar.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/topBar.dart';

class ScaffoldBuilder extends StatefulWidget {
  final String currentPath;
  final String pageName;
  final Widget child;
  final VoidCallback onMonthSelection;

  const ScaffoldBuilder({
    super.key,
    required this.currentPath,
    required this.pageName,
    required this.child,
    required this.onMonthSelection,
  });

  @override
  State<ScaffoldBuilder> createState() => _ScaffoldBuilderState();
}

class _ScaffoldBuilderState extends State<ScaffoldBuilder> {
  CompanyApiResponse? _companyData;
  AdminApiResponse? _adminData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  // Future<void> _refreshDataBasedOnRole(bool isCompany) async {
  //   setState(() {
  //     isLoading = true; // Set loading state
  //   });

  //   if (isCompany) {
  //     // Fetch company data
  //     CompanyApiResponse companyData = await ApiServices.companyData();
  //     _companyData = companyData;
  //   } else {
  //     // Fetch admin data
  //     AdminApiResponse adminData = await ApiServices.adminData();
  //     _adminData = adminData;
  //   }

  //   setState(() {
  //     isLoading = false; // Set loading state to false after fetching
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgcolor,
      drawer: SidebarDrawer(currentPath: widget.currentPath),
      body: Row(
        children: [
          if (size.width > 900) Sidebar(currentPath: widget.currentPath),
          Expanded(
            child: Column(
              children: [
                const TopBar(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(10.0),
                    children: [
                      PageAndDate(
                        onMonthSelect: () {
                          widget.onMonthSelection();
                        },
                        pageLabel: widget.pageName,
                        currentPage: widget.currentPath,
                      ),
                      const SizedBox(height: 10),
                      if (widget.currentPath != "Settings" &&
                          widget.currentPath != "Profile" &&
                          widget.currentPath != "Terms") // Added null check
                        const OverViewCards(),
                      const SizedBox(height: 10),
                      SizedBox(child: widget.child),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
