import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/RecruitmentBarChart.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/colorDeclaration.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/statisticTable.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/verticalTable.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CompanyStatisticScreen extends StatelessWidget {
  const CompanyStatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBuilder(
      pageName: "Statistics",
      currentPath: "Statistics",
      child: LayoutBuilder(
        builder: (context, constraints) {
          // If screen width is greater than 1200, use Row layout
          if (constraints.maxWidth > 1200) {
            return _buildRowLayout(context, constraints.maxWidth);
          } else {
            // If screen width is less than or equal to 1200, use ListView (stacked) layout
            return _buildListViewLayout(
              context,
            );
          }
        },
      ),
    );
  }

  // Build the two-column layout (for screen width > 1200)
  Widget _buildRowLayout(context, double screenWidth) {
    // containing total child
    return SizedBox(
      // height: 401,
      // 3 sections
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: white,
              ),
              // chart and table
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    // color: yellow,
                    height: 500,
                    width: screenWidth *
                        .34, // Dynamic width for RecruitmentBarChart
                    child: const Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Recruitment",
                              style: AppTextStyle.normalText,
                            ),
                          ),
                        ),
                        RecruitmentBarChart(
                          mobilelength: 400,
                          length: 400,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    // color: bluee,
                    height: 500,
                    width: screenWidth * 0.15,
                    child: const Statisticpagetable(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 500,
              child: Row(
                children: [
                  Expanded(
                    child: radialContainer(
                      context,
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
                      context,
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
          ),
        ],
      ),
    );
  }

  // Build the stacked (vertical) layout for smaller screens (<= 1200)
  Widget _buildListViewLayout(
    context,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: white,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 450,
                    width: double.infinity, // Take full width in stacked view
                    child: RecruitmentBarChart(
                      mobilelength: 400,
                      length: 350,
                    ),
                  ),
                  SizedBox(
                    height: 450,
                    width: double.infinity, // Take full width in stacked view
                    child: Statisticpagetable(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 500,
              width: double.infinity, // Take full width
              child: Column(
                children: [
                  Expanded(
                    child: radialContainer(
                      context,
                      isGradient: true,
                      title: "Current month",
                      totalApplied: 82,
                      gotJobs: 60,
                      color: green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: radialContainer(
                      context,
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
    );
  }
}

Widget radialContainer(
  context, {
  required String title,
  required Color color,
  required double totalApplied,
  required double gotJobs,
  required bool isGradient,
}) {
  Size size = MediaQuery.of(context).size;

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
            colorDeclaration(title: title),
          ],
        ),
        const SizedBox(height: 5),
        Expanded(
          child: size.width > 1200
              ? Column(
                  children: [
                    Expanded(
                      child: IndividualRadialGauge(
                        isgradient: isGradient,
                        maxValue: totalApplied,
                        value: totalApplied,
                        color: color,
                        description: "applicants applied\nthis month",
                        count: totalApplied.toInt(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: IndividualRadialGauge(
                        isgradient: false,
                        maxValue: totalApplied,
                        value: gotJobs,
                        color: color,
                        count: gotJobs.toInt(),
                        description: "applicants has \ngot jobs",
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: IndividualRadialGauge(
                        isgradient: isGradient,
                        maxValue: totalApplied,
                        value: totalApplied,
                        color: color,
                        description: "applicants applied\nthis month",
                        count: totalApplied.toInt(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: IndividualRadialGauge(
                        isgradient: false,
                        maxValue: totalApplied,
                        value: gotJobs,
                        color: color,
                        count: gotJobs.toInt(),
                        description: "applicants has \ngot jobs",
                      ),
                    ),
                  ],
                ),
        ),
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${count}K",
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
                        style: const TextStyle(
                          fontSize: 10,
                          color: black,
                          height: 1.0,
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
