import 'package:flutter/material.dart';
import 'package:kbn_test/service/adminMode.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/singletonData.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/view/auth/logInPage.dart';
import 'package:kbn_test/view/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/view/screen/UPDATED%20UI/Widgets/RecruitmentBarChart.dart';
import 'package:kbn_test/view/screen/UPDATED%20UI/Widgets/statisticTable.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../service/companymodelClass.dart';

class CompanyStatisticScreen extends StatefulWidget {
  const CompanyStatisticScreen({super.key});

  @override
  State<CompanyStatisticScreen> createState() => _CompanyStatisticScreenState();
}

class _CompanyStatisticScreenState extends State<CompanyStatisticScreen> {
  CompanyApiResponse? _companyData;
  AdminApiResponse? _adminData;
  bool _isLoading = true;
  bool _hasError = false;
  final String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // ignore: prefer_typing_uninitialized_variables
      var data;
      if (isCompany) {
        data = await ApiServices.companyData();
        // data = await ApiDataService().fetchCompanyData();
        setState(() {
          _companyData = data;
          _isLoading = false;
        });
      } else {
        data = await ApiServices.adminData();
        setState(() {
          _adminData = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        // _errorMessage = e.toString();
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

//   Future<void> _fetchDataBasedOnRole() async {
//   try {
//     var data = isCompany
//         ? await ApiServices.companyData()
//         : await ApiServices.adminData();

//     setState(() {
//       if (isCompany) {
//         _companyData = data as CompanyApiResponse?;
//       } else {
//         _adminData = data as AdminApiResponse?;
//       }
//       _isLoading = false;
//     });
//   } catch (e) {
//     setState(() {
//       _hasError = true;
//       _isLoading = false;
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error fetching data: $e')),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBuilder(
      onMonthSelection: () {
        _fetchData();
      },
      pageName: "Statistics",
      currentPath: "Statistics",
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(
              context,
              companyData: _companyData,
              adminData: _adminData,
            ),
    );
  }

  // Unified content layout, responsive without LayoutBuilder
  Widget _buildContent(
    BuildContext context, {
    companyData,
    adminData,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 1450
        ? _buildRowLayout(context, screenWidth)
        : _buildColumnLayout(context, screenWidth);
  }

  Widget _buildRowLayout(BuildContext context, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildChartAndTableSection(context, screenWidth),
        const SizedBox(width: 5),
        _buildRadialGaugeSection(context, screenWidth),
      ],
    );
  }

  Widget _buildColumnLayout(BuildContext context, double screenwidth) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: white,
            ),
            height: 500,
            child: _buildRecruitmentChart(screenwidth),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            // height:screenwidth>580? 100:150,
            child: _buildStatisticTable(screenwidth),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: screenwidth > 600 ? 500 : 1000,
            child: _buildRadialGaugeSection(context, screenwidth),
          ),
        ],
      ),
    );
  }

  // Simplified chart and table section
  Widget _buildChartAndTableSection(
    BuildContext context,
    double screenWidth,
  ) {
    return Expanded(
      flex: 1,
      child: Container(
          // height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildRecruitmentChart(screenWidth * 0.3),
              _buildStatisticTable(screenWidth * 0.12),
            ],
          )),
    );
  }

  Widget _buildRecruitmentChart(double width) {
    return Container(
      height: 500,
      width: width,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text("Recruitment", style: AppTextStyle.normalText),
            ),
          ),
          RecruitmentBarChart(
            recruitmentData:
                _companyData?.companyData?.statisticsPageData?.recruitment,
            performanceData:
                _adminData?.adminData?.statisticsPageData?.performance,
            mobilelength: 400,
            length: 400,
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticTable(
    double width,
  ) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 500,
      width: width,
      child: size.width > 1450
          ? Statisticpagetable(
              recruitmentData:
                  _companyData?.companyData?.statisticsPageData?.recruitment,
              performanceData:
                  _adminData?.adminData?.statisticsPageData?.performance,
            )

          /// same table which horizontaly aligned
          : HorizontalStatistic(
              recruitmentData:
                  _companyData?.companyData?.statisticsPageData?.recruitment,
              performanceData:
                  _adminData?.adminData?.statisticsPageData?.performance,
            ),
    );
  }

  Widget _buildRadialGaugeSection(BuildContext context, double screenwidth) {
    final totalApplicantsThisMonth = isCompany
        ? _companyData!.companyData?.commonData?.applicantsTotal?.thisMonth ?? 1
        : _adminData?.adminData?.statisticsPageData?.currMonthTotalApplicants ??
            1;

    final totalApplicantsPrevMonth = isCompany
        ? _companyData?.companyData?.commonData?.applicantsTotal?.prevMonth ?? 1
        : _adminData?.adminData?.statisticsPageData?.prevMonthTotalApplicants ??
            1;

    final selectedApplicantsThisMonth = isCompany
        ? _companyData
                ?.companyData?.commonData?.applicantsSelected?.thisMonth ??
            0
        : _adminData
                ?.adminData?.statisticsPageData?.currMonthSelectedApplicants ??
            0;

    final selectedApplicantsPrevMonth = isCompany
        ? _companyData
                ?.companyData?.commonData?.applicantsSelected?.prevMonth ??
            0
        : _adminData
                ?.adminData?.statisticsPageData?.prevMonthSelectedApplicants ??
            0;

    // if (totalApplicantsThisMonth == null || totalApplicantsPrevMonth == null) {
    //   return const Center(child: Text("No Pie Data available"));
    // }

    return Expanded(
      flex: 1,
      child: SizedBox(
        height: 500,
        child: screenwidth > 600
            ? Row(
                children: [
                  _buildRadialContainer(
                    context,
                    "Current month",
                    totalApplicantsThisMonth.toDouble(),
                    selectedApplicantsThisMonth.toDouble(),
                    green,
                    true,
                  ),
                  const SizedBox(width: 10),
                  _buildRadialContainer(
                    context,
                    "Previous month",
                    totalApplicantsPrevMonth.toDouble(),
                    selectedApplicantsPrevMonth.toDouble(),
                    tealblue,
                    false,
                  ),
                ],
              )
            : Column(
                children: [
                  _buildRadialContainer(
                    context,
                    "Current month",
                    totalApplicantsThisMonth.toDouble(),
                    selectedApplicantsThisMonth.toDouble(),
                    green,
                    true,
                  ),
                  const SizedBox(height: 10),
                  _buildRadialContainer(
                    context,
                    "Previous month",
                    totalApplicantsPrevMonth.toDouble(),
                    selectedApplicantsPrevMonth.toDouble(),
                    tealblue,
                    false,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildRadialContainer(
    BuildContext context,
    String title,
    double totalApplied,
    double gotJobs,
    Color color,
    bool isGradient,
  ) {
    return Expanded(
      child: radialContainer(
        context,
        title: title,
        totalApplied: totalApplied,
        gotJobs: gotJobs,
        color: color,
        isGradient: isGradient,
      ),
    );
  }
}

Widget radialContainer(BuildContext context,
    {required String title,
    required double totalApplied,
    required double gotJobs,
    required Color color,
    required bool isGradient}) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          runAlignment: WrapAlignment.start,
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 5,
          spacing: 10,

          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Total Applicants"),
            Text(title),
          ],
        ),
        const SizedBox(height: 5),
        Expanded(
          child: Column(
            children: [
              _buildIndividualGauge(context, totalApplied, totalApplied, color,
                  "applicants applied\nthis month", isGradient),
              const SizedBox(height: 20),
              _buildIndividualGauge(context, totalApplied, gotJobs, color,
                  "applicants has \ngot jobs", false),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildIndividualGauge(
  BuildContext context,
  double maxValue,
  double value,
  Color color,
  // int count,
  String description,
  bool isGradient,
) {
  double adjustedMaxValue = maxValue > 0 ? maxValue : 1;
    double screenWidth = MediaQuery.of(context).size.width;
      double proportionalFontSize = (screenWidth * 0.05).clamp(18.0, 24.0); // Adjust the multiplier and clamp values as needed

  return Expanded(
    child: SfRadialGauge(
      axes: [
        RadialAxis(
          minimum: 0,
          maximum: adjustedMaxValue,
          radiusFactor: 1.0,
          pointers: [
            RangePointer(
              value: value,
              cornerStyle: CornerStyle.bothCurve,
              gradient: isGradient ? sweepGradient : null,
              color: isGradient ? null : color,
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
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "${value.toInt()}",
                      style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: proportionalFontSize,
                          color: black),
                    ),
                  ),
                  if(screenWidth>180)
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(description,
                        style: const TextStyle(fontSize: 10, color: black)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
