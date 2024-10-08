import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

class RecruitmentBarChart extends StatelessWidget {
  final double length;
  final double mobilelength;
  const RecruitmentBarChart(
      {super.key, required this.length, required this.mobilelength});

  @override
  Widget build(
    BuildContext context,
  ) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: white,
      height: size.width > 900 ? length : mobilelength,
      // width: size.width<600?size.width*.3:null,
      padding: const EdgeInsets.all(8.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100, // Max percentage height of bars
          barGroups: [
            makeGroupData(0, 65, 42), // Data for Python
            makeGroupData(1, 30, 20), // Data for UI/UX
            makeGroupData(2, 75, 55), // Data for Development
            makeGroupData(
                3, 80, 65), // Java: current month 80%, previous month 65%
          ],
          titlesData: FlTitlesData(
            show: true,
            topTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false, // Hide the Y-axis titles on the left
              ),
            ),
            // Hide left and right titles
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false, // Hide the Y-axis titles on the left
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false, // Hide the Y-axis titles on the right
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                    fontSize: 10,
                  );

                  Widget text;
                  switch (value.toInt()) {
                    case 0:
                      text = const Text('Python', style: style);
                      break;
                    case 1:
                      text = const Text('UI/UX', style: style);
                      break;
                    case 2:
                      text = const Text('Development', style: style);
                      break;
                    case 3:
                      text = const Text('Java', style: style);
                      break;
                    default:
                      text = const Text('');
                      break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 8.0,
                    child: text,
                  );
                },
              ),
            ),
            // leftTitles: AxisTitles(
            //   sideTitles: SideTitles(
            //     showTitles: true, // If you want to display Y-axis titles
            //     reservedSize: 20, // Space for Y-axis titles
            //     getTitlesWidget: (value, meta) {
            //       if (value % 10 == 0) {
            //         return Text(value.toInt().toString());
            //       }
            //       return const SizedBox(); // Skip intermediate labels
            //     },
            //   ),
            // ),
          ),

          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(color: Colors.black, width: 1), // Left side
              bottom: BorderSide(color: Colors.black, width: 1), // Bottom side
            ),
          ),

          barTouchData: BarTouchData(
            enabled: false,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (barGroup) =>
                  // tool tip backGround Color
                  Colors.white.withOpacity(0.1),
              tooltipPadding: const EdgeInsets.all(8),
              tooltipMargin: 8,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  rod.toY
                      .toString(), // Display the value directly above the bar
                  const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    backgroundColor: Colors.transparent,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          extraLinesData:
              const ExtraLinesData(), // Ensure no extra lines interfere
        ),
      ),
    );
  }

  // Function to generate bar groups
  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          width: 30,
          gradient: gradientColor,
          borderRadius: BorderRadius.circular(4),
        ),
        BarChartRodData(
          toY: y2,
          width: 15,
          color: tealblue,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
      showingTooltipIndicators: [0, 1],
    );
  }
}
