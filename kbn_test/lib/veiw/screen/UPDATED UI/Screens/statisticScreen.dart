import 'package:flutter/material.dart';
import 'package:kbn_test/service/adminMode.dart';
import 'package:kbn_test/service/singletonData.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/RecruitmentBarChart.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/statisticTable.dart';
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
        data = await ApiDataService().fetchCompanyData();
        setState(() {
          _companyData = data;
          _isLoading = false;
        });
      } else {
        data = await ApiDataService().fetchAdminData();
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

  @override
  Widget build(BuildContext context) {
    return ScaffoldBuilder(
      pageName: "Statistics",
      currentPath: "Statistics",
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(child: Text('Error: $_errorMessage'))
              : _companyData == null && _adminData == null
                  ? const Center(child: Text("No data available"))
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
    return screenWidth > 1200
        ? _buildRowLayout(context, screenWidth)
        : _buildColumnLayout(context);
  }

  Widget _buildRowLayout(BuildContext context, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildChartAndTableSection(context, screenWidth),
        const SizedBox(width: 5),
        _buildRadialGaugeSection(context),
      ],
    );
  }

  Widget _buildColumnLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildChartAndTableSection(
              context, MediaQuery.of(context).size.width),
          const SizedBox(height: 10),
          _buildRadialGaugeSection(context),
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
        ),
      ),
    );
  }

  Widget _buildRecruitmentChart(double width) {
    return SizedBox(
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
                _companyData?.companyData.statisticsPageData.recruitment,
            performanceData:
                _adminData?.adminData.statisticsPageData.performance,
            mobilelength: 400,
            length: 400,
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticTable(double width) {
    return SizedBox(
      height: 500,
      width: width,
      child: Statisticpagetable(
        recruitmentData:
            _companyData?.companyData.statisticsPageData.recruitment,
        performanceData: _adminData?.adminData.statisticsPageData.performance,
      ),
    );
  }

  Widget _buildRadialGaugeSection(BuildContext context) {
    final totalApplicantsThisMonth = isCompany
        ? _companyData?.companyData.commonData.applicantsTotal.thisMonth
        : _adminData?.adminData.statisticsPageData.currMonthTotalApplicants;

    final totalApplicantsPrevMonth = isCompany
        ? _companyData?.companyData.commonData.applicantsTotal.prevMonth
        : _adminData?.adminData.statisticsPageData.prevMonthTotalApplicants;

    final selectedApplicantsThisMonth = isCompany
        ? _companyData?.companyData.commonData.applicantsSelected.thisMonth
        : _adminData?.adminData.statisticsPageData.currMonthSelectedApplicants;

    final selectedApplicantsPrevMonth = isCompany
        ? _companyData?.companyData.commonData.applicantsSelected.prevMonth
        : _adminData?.adminData.statisticsPageData.prevMonthSelectedApplicants;

    if (totalApplicantsThisMonth == null || totalApplicantsPrevMonth == null) {
      return const Center(child: Text("No Pie Data available"));
    }

    return Expanded(
      flex: 1,
      child: SizedBox(
        height: 500,
        child: Row(
          children: [
            _buildRadialContainer(
              context,
              "Current month",
              totalApplicantsThisMonth.toDouble(),
              selectedApplicantsThisMonth!.toDouble(),
              green,
              true,
            ),
            const SizedBox(width: 10),
            _buildRadialContainer(
              context,
              "Previous month",
              totalApplicantsPrevMonth.toDouble(),
              selectedApplicantsPrevMonth!.toDouble(),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
  return Expanded(
    child: SfRadialGauge(
      axes: [
        RadialAxis(
          minimum: 0,
          maximum: maxValue,
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
                  Text(
                    "${value.toInt()}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: black),
                  ),
                  Text(description,
                      style: const TextStyle(fontSize: 10, color: black)),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
