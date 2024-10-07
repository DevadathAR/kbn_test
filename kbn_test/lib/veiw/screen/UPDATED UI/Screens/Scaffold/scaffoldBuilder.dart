import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/modelClass.dart';

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
      backgroundColor: textGrey,
      drawer: SidebarDrawer(currentPath: widget.currentPath),
      body: Row(
        children: [
          if (size.width > 900) Sidebar(currentPath: widget.currentPath),
          Expanded(
            child: Column(
              children: [
                const TopBar(),
                const SizedBox(height: 10),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        PageAndDate(pageLabel: widget.pageName),
                        const SizedBox(height: 10),
                        if (widget.currentPath != "Settings" &&
                            widget.currentPath != "Profile" &&
                            widget.currentPath != "Terms") // Added null check
                          const overViewCards(),
                        const SizedBox(height: 10),
                        SizedBox(
                            height: widget.currentPath != "Settings" &&
                                    widget.currentPath != "Profile" &&
                                    widget.currentPath != "Terms"
                                ? size.width > 900
                                    ? size.height - 300
                                    : size.height - 340
                                : size.width > 900
                                    ? size.height - 180
                                    : size.height - 220,
                            child: widget.child),
                      ],
                    ),
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
