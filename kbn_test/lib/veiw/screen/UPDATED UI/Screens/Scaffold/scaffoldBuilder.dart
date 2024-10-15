import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/companyModelClass.dart';

import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/drawer.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/horizontalCardList.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/page_and_date.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/sidebar.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/topBar.dart';

const bool isCompany = true;

class ScaffoldBuilder extends StatefulWidget {
  final String currentPath;
  final String pageName;
  final Widget child;

  const ScaffoldBuilder({
    super.key,
    required this.currentPath,
    required this.pageName,
    required this.child,
  });

  @override
  State<ScaffoldBuilder> createState() => _ScaffoldBuilderState();
}

class _ScaffoldBuilderState extends State<ScaffoldBuilder> {
  @override
  void initState() {
    super.initState();
  }

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
                      PageAndDate(pageLabel: widget.pageName,currentPage: widget.currentPath),
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
