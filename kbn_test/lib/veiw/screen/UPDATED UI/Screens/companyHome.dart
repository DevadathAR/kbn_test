import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/messageScreen.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/chartWidget.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/messageWidget.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/payResult.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/payReminder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/simpleTable.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/verticalTable.dart';

class CompanyHome extends StatelessWidget {
  const CompanyHome({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ScaffoldBuilder(
      pageName: "Overview",
      currentPath: "Overview",
      child: SizedBox(
        // height: 410,
        child: Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            // First column (Charts and Horizontal Table)
            SizedBox(
              width: size.width > 1200 ? 600 : null,
              child: const Column(
                children: [
                  ChartWidget(),
                  SizedBox(height: 10),
                  HorizontalTable(),
                ],
              ),
            ),

            // Second column (Vertical Table)
            SizedBox(
              width: size.width > 1200
                  ? (size.width - 200) * 0.33
                  : null, // Adjust the width as necessary
              child: const VerticalTable(),
            ),

            // Third column (Message and Pay Result)
            SizedBox(
              width: size.width > 1200
                  ? (size.width - 200) * 0.2
                  : null, // Adjust the width as necessary
              child: Column(
                children: [
                  // MessageWidget(),
                  messagePageList(context,
                      hight: 270,
                      viewreplybutton: false,
                      tilehight: 65,
                      imgsize: 40,
                      tilecount: 3,
                      paddingseparation: 5),
                  const SizedBox(height: 10),
                  isCompany ? const PayRemainder() : const PayResult(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
