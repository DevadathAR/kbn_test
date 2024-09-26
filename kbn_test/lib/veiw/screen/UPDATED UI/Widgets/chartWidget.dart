import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/RecruitmentBarChart.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/colorDeclaration.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/latestPie.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), color: white),
      height: 220, // Define a fixed height for the container
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Flexible(
            flex: 2,
            child: RecruitmentBarChart(),
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
                Column(
                  children: [
                    colorDeclaration(title: currentMonth),
                    const SizedBox(height: 5),
                    colorDeclaration(title: previousMonth)
                  ],
                )
              ],
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
