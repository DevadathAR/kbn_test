import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/service/adminMode.dart';
import 'package:kbn_test/service/companymodelClass.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

class RecruitmentBarChart extends StatelessWidget {
  final double length;
  final double mobilelength;
  final List<Recruitment>? recruitmentData; // Accept recruitment data
  final List<Performance>? performanceData;   // Accept performance data

  const RecruitmentBarChart({
    super.key,
    required this.length,
    required this.mobilelength,
    this.recruitmentData, // Nullable recruitment data
    this.performanceData,  // Nullable performance data
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.width > 900 ? length : mobilelength,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: size.width*0.5,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 100, // Max percentage height of bars
              barGroups: (recruitmentData != null)
                  ? recruitmentData!.asMap().entries.map((entry) {
                      int index = entry.key; // Get the index of the recruitment item
                      Recruitment recruitment = entry.value; // Get the recruitment data
                      return makeGroupData(
                          index, recruitment.currentMonth, recruitment.prevMonth);
                    }).toList()
                  : performanceData!.asMap().entries.map((entry) {
                      int index = entry.key; // Get the index of the performance item
                      Performance performance = entry.value; // Get the performance data
                      return makeGroupDataFromPerformance(
                          index, performance.performancePercentageThisMonth, performance.performancePercentagePrevMonth);
                    }).toList(),
              titlesData: FlTitlesData(
                show: true,
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 30,
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      const style = TextStyle(fontSize: 10);
                      int index = value.toInt();
                      String title = recruitmentData != null
                          ? index < recruitmentData!.length
                              ? recruitmentData![index].jobTitle
                              : ''
                          : index < performanceData!.length
                              ? performanceData![index].companyName
                              : '';
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 1.0,
                        child: SizedBox(
                          width: 45,
                          child: Text(
                            title,
                            style: style,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            softWrap: true,
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
                  left: BorderSide(color: Colors.black, width: 1),
                  bottom: BorderSide(color: Colors.black, width: 1),
                ),
              ),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (barGroup) => Colors.white.withOpacity(0.1),
                  tooltipPadding: const EdgeInsets.all(8),
                  tooltipMargin: 8,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
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
              extraLinesData: const ExtraLinesData(),
            ),
          ),
        ),
      ),
    );
  }

  // Function to generate bar groups for Recruitment
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

  // Function to generate bar groups for Performance
  BarChartGroupData makeGroupDataFromPerformance(int x, String y1, String y2) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: double.tryParse(y1) ?? 0.0,
          width: 25,
          gradient: gradientColor,
          borderRadius: BorderRadius.circular(4),
        ),
        BarChartRodData(
          toY: double.tryParse(y2) ?? 0.0,
          width: 15,
          color: tealblue,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
      showingTooltipIndicators: [0, 1],
    );
  }
}
