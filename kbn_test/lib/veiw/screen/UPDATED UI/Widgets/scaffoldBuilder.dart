import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/overView.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/chartWidget.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/messageWidget.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/horizontalCardList.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/horizontalCards.dart.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/page_and_date.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/payResult.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/sidebar.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/simpleTable.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/topBar.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/verticalTable.dart';

class ScaffoldBuilder extends StatelessWidget {
  final String currentPath;
  final String pageName;
  final Widget child;
  // final Widget page_n_date;
  const ScaffoldBuilder({
    super.key,
    required this.child,
    required this.currentPath,
    required this.pageName,
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
