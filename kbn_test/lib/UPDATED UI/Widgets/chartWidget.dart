import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/RecruitmentBarChart.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/colorDeclaration.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/latestPie.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget chartWidget(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  
  // Check if the screen width is below 900
  bool isSmallScreen = size.width < 900;

  return Container(
    decoration: BoxDecoration(
      boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      borderRadius: BorderRadius.circular(8),
      color: white,
    ),
    height: isSmallScreen ? 440 : 250, // Adjust height for small screens
    child: isSmallScreen 
        ? smallSCreenLayout()
        : largeSCrennLayout(),
  );
}

Row largeSCrennLayout() {
  return Row( // Display charts side by side for larger screens
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
             Flexible(
              flex: 2,
              child: RecruitmentBarChart(length: 203,mobilelength: 163,),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 180,
                    child: SyncfusionPieChart(),
                  ),
                  Container(child: Column(children: [colorDeclaration(title: currentMonth),
            const SizedBox(height: 5),
            colorDeclaration(title: previousMonth),],),)
                ],
              ),
            ),
            const SizedBox(width: 5),
          ],
        );
}

Column smallSCreenLayout() {
  return Column( // Display charts in a column for small screens
          children: [
            SizedBox(
              height: 180,
              child: RecruitmentBarChart(length: 203,mobilelength: 163,),
            ),
            const SizedBox(height: 20), // Add spacing between charts
            const SizedBox(
              height: 180,
              child: SyncfusionPieChart(),
            ),
            const SizedBox(height: 10),
            Container(child: Column(children: [colorDeclaration(title: currentMonth),
            const SizedBox(height: 5),
            colorDeclaration(title: previousMonth),],),)
            
          ],
        );
}
