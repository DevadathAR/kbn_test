import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/service/modelClass.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

class RecruitmentBarChart extends StatelessWidget {
  final double length;
  final double mobilelength;
  final List<Recruitment> data; // Accept data dynamically

  const RecruitmentBarChart(
      {super.key,
      required this.length,
      required this.mobilelength,
      required this.data});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      // color: Colors.amber,
      height: size.width > 900 ? length : mobilelength,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        scrollDirection: Axis.horizontal,
        // scrollDirection: Axis.vertical,

        child: SizedBox(
          width:(size.width)*0.5,
              // data.length * 60, // Dynamically set width based on number of bars
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 100, // Max percentage height of bars
              barGroups: data.asMap().entries.map((entry) {
                int index = entry.key; // Get the index of the recruitment item
                Recruitment recruitment =
                    entry.value; // Get the recruitment data
                return makeGroupData(
                    index, recruitment.currentMonth, recruitment.prevMonth);
              }).toList(),
              titlesData: FlTitlesData(
                show: true,
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false, // Hide the Y-axis titles on the left
                  ),
                ),
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
                    reservedSize: 30,
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      const style = TextStyle(
                        fontSize: 10,
                      );

                      // Access the job title dynamically based on index
                      int index = value.toInt();
                      String title =
                          index < data.length ? data[index].jobTitle : '';

                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 1.0,
                        child: SizedBox(
                          // color: bluee,
                          width:
                              45, // Increase the width to accommodate two lines
                          child: Text(
                            title,
                            style: style,
                            textAlign:
                                TextAlign.center, // Align the text to the left
                            maxLines: 2, // Allow text to wrap into two lines
                            // Let the text wrap instead of ellipsis
                            softWrap:
                                true, // Ensure the text can break into multiple lines
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  left: BorderSide(color: Colors.black, width: 1), // Left side
                  bottom:
                      BorderSide(color: Colors.black, width: 1), // Bottom side
                ),
              ),
              barTouchData: BarTouchData(
                enabled: true, // Enable touch to see tooltips
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (barGroup) => Colors.white.withOpacity(0.1),
                  tooltipPadding: const EdgeInsets.all(8),
                  tooltipMargin: 8,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    // Display value as percentage
                    return BarTooltipItem(
                      '${rod.toY.toStringAsFixed(1)}%', // Display as percentage
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
        ),
      ),
    );
  }

  // Function to generate bar groups
  BarChartGroupData makeGroupData(int x, int y1, int y2) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1.toDouble(),
          width: 25,
          gradient: gradientColor,
          borderRadius: BorderRadius.circular(4),
        ),
        BarChartRodData(
          toY: y2.toDouble(),
          width: 15,
          color: tealblue,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
      showingTooltipIndicators: [0, 1],
    );
  }
}
