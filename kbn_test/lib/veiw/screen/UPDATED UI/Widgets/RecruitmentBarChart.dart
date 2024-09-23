import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RecruitmentBarChart extends StatelessWidget {
  const RecruitmentBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround // More space between bars
          ,
          maxY: 100, // Max percentage height of bars
          barGroups: [
            makeGroupData(
              0,
              65,
              42,
            ),
            makeGroupData(
              1,
              30,
              20,
            ),
            makeGroupData(
              2,
              75,
              55,
            ),
          ],
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                    // color: Colors.black,
                    fontSize: 12,
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
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xFF000000), width: 1),
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          width: 20,
          gradient: const LinearGradient(
            colors: [Color(0xFF00BFA5), Color.fromARGB(255, 10, 223, 96)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        BarChartRodData(
          toY: y2,
          width: 10,
          gradient: const LinearGradient(
            colors: [Color(0xFF00695C), Color(0xFF00796B)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }
}
