 import 'package:flutter/material.dart';
import 'package:kbn_test/service/modelClass.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/RecruitmentBarChart.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/colorDeclaration.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/latestPie.dart';

class ChartWidget extends StatelessWidget {
  final CompanyData companyData; // Accept statistics data

  const ChartWidget({
    super.key,
    required this.companyData,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSmallScreen = size.width < 900;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 1),
        ],
        borderRadius: BorderRadius.circular(8),
        color: white,
      ),
      height: isSmallScreen ? 440 : 250, // Fixed height for container
      child: isSmallScreen ? smallScreenLayout() : largeScreenLayout(),
    );
  }

  // Small screen layout: Vertical arrangement of charts
  Column smallScreenLayout() {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: RecruitmentBarChart(
            data:
                companyData.statisticsPageData.recruitment, // Pass dynamic data

            length: 203,
            mobilelength: 163,
          ),
        ),
        const SizedBox(height: 20), // Add spacing between charts
        SizedBox(
          height: 180,
          child: SyncfusionPieChart(
            commonData: companyData.commonData, // Pass dynamic data
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            colorDeclaration(title: currentMonth),
            const SizedBox(height: 5),
            colorDeclaration(title: previousMonth),
          ],
        ),
      ],
    );
  }

  // Large screen layout: Horizontal arrangement of charts
  Row largeScreenLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 2,
          child: SizedBox(
            height: 220,
            child: RecruitmentBarChart(
              data: companyData
                  .statisticsPageData.recruitment, // Pass dynamic data
              length: 220,
              mobilelength: 163,
            ),
          ),
        ),
        const SizedBox(width: 5),
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: SyncfusionPieChart(
                  commonData: companyData.commonData, // Pass dynamic data
                ),
              ),
              Column(
                children: [
                  colorDeclaration(title: currentMonth),
                  const SizedBox(height: 5),
                  colorDeclaration(title: previousMonth),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}
