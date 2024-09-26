import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';

class RecruitmentBarChart extends StatelessWidget {
  const RecruitmentBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
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
            enabled: false, // Disable touch interaction
            touchTooltipData: BarTouchTooltipData(
              tooltipPadding: const EdgeInsets.all(8),
              tooltipMargin: 8,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  rod.toY
                      .toString(), // Display the value directly above the bar
                  const TextStyle(
                    fontSize: 8,
                    color: Colors.white,
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
          width: 20,
          gradient: gradientColor,
          borderRadius: BorderRadius.circular(4),
          // rodStackItems: [
          //   BarChartRodStackItem(
          //     0,
          //     y1,
          //     Colors.transparent,
          //   ),
          // ],
        ),
        BarChartRodData(
          toY: y2,
          width: 10,
          color: tealblue,
          borderRadius: BorderRadius.circular(4),
          // rodStackItems: [
          //   BarChartRodStackItem(
          //     0,
          //     y2,
          //     Colors.transparent,
          //   ),
          // ],
        ),
      ],
      showingTooltipIndicators: [0, 1],
    );
  }
}
