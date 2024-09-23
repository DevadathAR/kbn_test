import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kbn_test/newUi/Company/view/CompanyMessage.dart';
import 'package:kbn_test/newUi/Company/widget/HorizontalCardList.dart';
import 'package:kbn_test/newUi/Company/widget/PageAndDate.dart';
import 'package:kbn_test/newUi/Company/widget/sidebar.dart';
import 'package:kbn_test/newUi/Company/widget/topbar.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';

class ScaffoldBuilder extends StatelessWidget {
  final Widget child;
  final String currentPath;
  final String pageName;
  const ScaffoldBuilder({
    required this.currentPath,
    required this.pageName,
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 195, 197, 197),
      body: Row(
        children: [
          // Nav Menu
          Expanded(
              flex: 1,
              child: Sidebar(
                currentPath: currentPath,
              )),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                // App bar
                const TopBar(),
                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  // Body Padding
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        PageAndDate(context, pageLabel: pageName),
                        const overViewCards(),
                        child
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
