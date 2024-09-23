import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/statistics.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/RecruitmentBarChart.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/pieChart.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/scaffoldBuilder.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBuilder(
        child: Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        height: 401,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: white,
                ),
                child: const RecruitmentBarChart(),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: white,
                ),
                child: const ApplicantPieChart(),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
