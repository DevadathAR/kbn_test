import 'package:flutter/material.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/CompanySection/CompanyScaffold/page_and_date.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/CompanySection/CompanyScaffold/horizontalCardList.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/CompanySection/CompanyScaffold/sidebar.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/CompanySection/CompanyScaffold/topBar.dart';

const bool isCompany = true;

class ScaffoldBuilder extends StatelessWidget {
  final String currentPath;
  final String pageName;
  final Widget child;
  // final Widget page_n_date;
  const ScaffoldBuilder({
    super.key,
    required this.currentPath,
    required this.pageName,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 195, 197, 197),
      body: Row(
        children: [
          // Nav Menu
          Sidebar(
            currentPath: currentPath,
          ),
          Expanded(
            child: Column(
              children: [
                // App bar
                const TopBar(),
                const SizedBox(height: 10),
                Flexible(
                  fit: FlexFit.loose,
                  // width: double.infinity,
                  // Body Padding
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        PageAndDate(context, pageLabel: pageName),
                        const SizedBox(height: 10),
                        const overViewCards(),
                        const SizedBox(height: 10),
                        child,
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
