import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/RecruitmentBarChart.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/colorDeclaration.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/CompanySection/CompanyScaffold/scaffoldBuilder.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CompanyStatisticScreen extends StatelessWidget {
  const CompanyStatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBuilder(
      pageName: "Statistics",
      currentPath: "Statistics",
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
                child: Row(
                  children: [
                    Expanded(
                      child: radialContainer(
                        isGradient: true,
                        title: "Current month",
                        totalApplied: 82,
                        gotJobs: 60,
                        color: green,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: radialContainer(
                        isGradient: false,
                        title: "Previous month",
                        totalApplied: 60,
                        gotJobs: 30,
                        color: tealblue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget radialContainer({
  required String title,
  required Color color,
  required double totalApplied,
  required double gotJobs,
  required bool isGradient,
}) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Total Applicants"),
            // Row(
            //   children: [
            //     Container(
            //       height: 15,
            //       width: 15,
            //       decoration: BoxDecoration(
            //         color: title == "Previous month" ? tealblue : null,
            //         borderRadius: BorderRadius.circular(2),
            //         gradient: title == "Current month" ? gradientColor : null,
            //       ),
            //     ),
            //     const SizedBox(width: 5),
            //     Text(title),
            //   ],
            // )
            colorDeclaration(title: title),
          ],
        ),
        const SizedBox(height: 5),
        Expanded(
          child: Column(
            children: [
              Expanded(
                // Total Applicants
                child: IndividualRadialGauge(
                  isgradient: isGradient,
                  maxValue: totalApplied,
                  value: totalApplied,
                  color: color,
                  description: "applicants applied\nthis month",
                  // count will be allways equal to the value

                  count: totalApplied.toInt(),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                // Applicants got jobs
                child: IndividualRadialGauge(
                  isgradient: false,
                  maxValue: totalApplied,
                  value: gotJobs,
                  color: color,
                  // count will be allways equal to the value
                  count: gotJobs.toInt(),
                  description: "applicants has \ngot jobs",
                ),
              ),
            ],
          ),
        ), // Second radial gauge
      ],
    ),
  );
}

class IndividualRadialGauge extends StatelessWidget {
  final bool isgradient;
  final double maxValue;
  final double value;
  final Color color;
  final int count;
  final String description;
  const IndividualRadialGauge(
      {super.key,
      required this.maxValue,
      required this.value,
      required this.color,
      required this.count,
      required this.description,
      required this.isgradient});

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          minimum: 0,
          maximum: maxValue,
          radiusFactor: 1.0,
          pointers: [
            RangePointer(
              value: value,
              cornerStyle: CornerStyle.bothCurve,
              // if gradient needed it will be gradient else it will be color
              gradient: isgradient ? sweepGradient : null,
              color: isgradient ? null : color,
              width: 25,
            ),
          ],
          axisLineStyle: const AxisLineStyle(thickness: 25),
          startAngle: -90,
          endAngle: 270,
          showLabels: false,
          showTicks: false,
          annotations: [
            GaugeAnnotation(
              widget: Column(
                mainAxisSize:
                    MainAxisSize.min, // Ensures the column is tightly packed
                children: [
                  Text(
                    "${count}K", // Adjust the label text as needed
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Wrap(
                    children: [
                      Text(
                        description,
                        // "applicants applied\nthis month", // Split text into two lines
                        style: const TextStyle(
                          fontSize: 10, // Reduced font size for smaller text
                          color: black,
                          height: 1.0, // Adjust line height for better spacing
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
              angle: 90,
              positionFactor: 0.0,
            ),
          ],
        ),
      ],
    );
  }
}
