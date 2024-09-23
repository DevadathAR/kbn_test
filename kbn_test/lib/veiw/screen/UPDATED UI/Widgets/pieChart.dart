import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ApplicantPieChart extends StatefulWidget {
  const ApplicantPieChart({super.key});

  @override
  State<ApplicantPieChart> createState() => _ApplicantPieChartState();
}

class _ApplicantPieChartState extends State<ApplicantPieChart> {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 3, // Space between sections
        centerSpaceRadius: 30, // Size of the inner circle
        sections: showingSections(),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      const isTouched = false; // Customize for interaction if needed
      const fontSize = isTouched ? 25.0 : 16.0;
      const radius = isTouched ? 60.0 : 50.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: 30,
            title: '30K',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '40K',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.teal,
            value: 90,
            title: '90K',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
