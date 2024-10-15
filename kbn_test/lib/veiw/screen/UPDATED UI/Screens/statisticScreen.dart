import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/service/singletonData.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/RecruitmentBarChart.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/colorDeclaration.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/statisticTable.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../service/companyModelClass.dart';

class CompanyStatisticScreen extends StatelessWidget {
  const CompanyStatisticScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldBuilder(
        pageName: "Statistics",
        currentPath: "Statistics",
        child: FutureBuilder(
          future: ApiDataService().fetchCompanyData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text("No data available"));
            }
            // Data is successfully fetched
            Apiresponse companyData = snapshot.data!;

            return LayoutBuilder(
              builder: (context, constraints) {
                // If screen width is greater than 1200, use Row layout
                if (constraints.maxWidth > 1200) {
                  return _buildRowLayout(
                      context, constraints.maxWidth, companyData);
                } else {
                  // If screen width is less than or equal to 1200, use ListView (stacked) layout
                  return _buildListViewLayout(context, companyData);
                }
              },
            );
          },
        ));
  }

  // Build the two-column layout (for screen width > 1200)
  Widget _buildRowLayout(context, double screenWidth, Apiresponse data) {
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
                        .3, // Dynamic width for RecruitmentBarChart
                    child: Column(
                      children: [
                        const Align(
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
                          data: data.companyData.statisticsPageData.recruitment,
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
                    child: Statisticpagetable(
                      data: data.companyData.statisticsPageData.recruitment,
                    ),
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
                      totalApplied: data
                          .companyData.commonData.applicantsTotal.thisMonth
                          .toDouble(),
                      gotJobs: data
                          .companyData.commonData.applicantsSelected.thisMonth
                          .toDouble(),
                      color: green,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: radialContainer(
                      context,
                      isGradient: false,
                      title: "Previous month",
                      totalApplied: data
                          .companyData.commonData.applicantsTotal.prevMonth
                          .toDouble(),
                      gotJobs: data
                          .companyData.commonData.applicantsSelected.prevMonth
                          .toDouble(),
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
  Widget _buildListViewLayout(context, Apiresponse data) {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 450,
                    width: double.infinity, // Take full width in stacked view
                    child: RecruitmentBarChart(
                      data: data.companyData.statisticsPageData.recruitment,
                      mobilelength: 400,
                      length: 350,
                    ),
                  ),
                  SizedBox(
                    height: 450,
                    width: double.infinity, // Take full width in stacked view
                    child: Statisticpagetable(
                      data: data.companyData.statisticsPageData.recruitment,
                    ),
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
                      totalApplied: data
                          .companyData.commonData.applicantsTotal.thisMonth
                          .toDouble(),
                      gotJobs: data
                          .companyData.commonData.applicantsSelected.thisMonth
                          .toDouble(),
                      color: green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: radialContainer(
                      context,
                      isGradient: false,
                      title: "Previous month",
                      totalApplied: data
                          .companyData.commonData.applicantsTotal.prevMonth
                          .toDouble(),
                      gotJobs: data
                          .companyData.commonData.applicantsSelected.thisMonth
                          .toDouble(),
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
                    "$count",
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
