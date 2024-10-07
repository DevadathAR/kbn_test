import 'package:flutter/material.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/drawer.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/horizontalCardList.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/page_and_date.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/sidebar.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/topBar.dart';

const bool isCompany = true;

// ScaffoldBuilder Widget
class ScaffoldBuilder extends StatelessWidget {
  final String currentPath;
  final String pageName;
  final Widget child;

  const ScaffoldBuilder({
    super.key,
    required this.child,
    required this.currentPath,
    required this.pageName,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 162, 255),
      // drawerDragStartBehavior: DragStartBehavior.down,
      // drawerScrimColor: none,
      // drawerEdgeDragWidth: 10,
      drawer: SidebarDrawer(currentPath: currentPath),
      // Display Drawer on small screens
      // No drawer for larger screens
      // backgroundColor: const Color.fromARGB(255, 195, 197, 197),
      body: Row(
        children: [
          // Sidebar for larger screens
          if (size.width > 900)
            Sidebar(
              currentPath: currentPath,),
          Expanded(
            child: Column(
              children: [
                // App bar
                const TopBar(),
                const SizedBox(height: 10),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        PageAndDate(pageLabel: pageName),
                        const SizedBox(height: 10),
                        if (currentPath != "Settings" &&
                            currentPath != "Profile" &&
                            currentPath != "Terms")
                          const overViewCards(),
                        if (currentPath != "Settings" &&
                            currentPath != "Profile" &&
                            currentPath != "Terms")
                          const SizedBox(height: 10),
                        Container(
                            height: currentPath != "Settings" &&
                                    currentPath != "Profile" &&
                                    currentPath != "Terms"
                                ? size.width > 900
                                    ? size.height - 300
                                    : size.height - 340
                                : size.width > 900
                                    ? size.height - 160
                                    : size.height - 200,
                            child: child),
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
