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
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/payResult.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/sidebar.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/simpleTable.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/topBar.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/verticalTable.dart';

class ScaffoldBuilder extends StatelessWidget {
  final Widget child;
  const ScaffoldBuilder({
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
          const Expanded(flex: 1, child: Sidebar()),
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
                        const overViewCards(),
                        child,
                        // OverviewScreen(),
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
