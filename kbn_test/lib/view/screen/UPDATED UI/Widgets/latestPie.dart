import 'package:flutter/material.dart';
import 'package:kbn_test/service/adminMode.dart';
import 'package:kbn_test/service/companymodelClass.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/view/auth/logInPage.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialArc {
  static RadialAxis build({
    required double startAngle,
    required double endAngle,
    required double radiusFactor,
    required Color arcColor,
    required double thickness,
    required double value,
    required double maxValue,
    required bool isGradient,
  }) {
    // Ensure that maxValue is greater than 0
    double adjustedMaxValue = maxValue > 0 ? maxValue : 1;

    return RadialAxis(
      minimum: 0,
      maximum: adjustedMaxValue,
      startAngle: startAngle,
      endAngle: endAngle,
      showLabels: false,
      showTicks: false,
      radiusFactor: radiusFactor,
      axisLineStyle: AxisLineStyle(
        thickness: thickness,
        cornerStyle: CornerStyle.bothCurve,
        color: Colors.white,
      ),
      pointers: <GaugePointer>[
        RangePointer(
          value: value,
          width: thickness,
          sizeUnit: GaugeSizeUnit.factor,
          gradient: isGradient ? sweepGradient : null,
          color: isGradient ? null : arcColor,
          cornerStyle: CornerStyle.bothCurve,
        ),
      ],
    );
  }
}

class SyncfusionPieChart extends StatelessWidget {
  final CompanyData? companyData; // You will pass CommonData here

  final AdminData? adminData;

  const SyncfusionPieChart({
    super.key,
    this.companyData,
    this.adminData,
  });

  @override
  Widget build(BuildContext context) {
    // Extract the required data
    // final totalApplicantsThisMonth = da;

    final totalApplicantsThisMonth = isCompany
        ? companyData?.commonData?.applicantsTotal?.thisMonth ?? 1
        : adminData?.statisticsPageData?.currMonthTotalApplicants ?? 1;

    final totalApplicantsPrevMonth = isCompany
        ? companyData?.commonData!.applicantsTotal?.prevMonth ?? 1
        : adminData?.statisticsPageData?.prevMonthTotalApplicants ?? 1;

    final selectedApplicantsThisMonth = isCompany
        ? companyData?.commonData?.applicantsSelected?.thisMonth ?? 0
        : adminData?.statisticsPageData?.currMonthSelectedApplicants ?? 0;

    final selectedApplicantsPrevMonth = isCompany
        ? companyData?.commonData?.applicantsSelected?.prevMonth ?? 0
        : adminData?.statisticsPageData?.prevMonthSelectedApplicants ?? 0;

    //     if (totalApplicantsThisMonth == null || totalApplicantsPrevMonth == null) {
    //   return const Center(child: Text("No Pie Data available"));
    // }

    return SfRadialGauge(
      // backgroundColor: textGrey,
      title: const GaugeTitle(
        alignment: GaugeAlignment.near,
        text: "Total Applicants",
        textStyle: AppTextStyle.bodytext_12,
      ),
      axes: <RadialAxis>[
        // Outer Green Arcs
        RadialArc.build(
          isGradient: true,
          maxValue: totalApplicantsThisMonth.toDouble(),
          startAngle: 230,
          endAngle: 230,
          radiusFactor: 1.0,
          arcColor: green,
          thickness: 0.3,
          value: totalApplicantsThisMonth.toDouble(),
        ),
        RadialArc.build(
          isGradient: false,
          maxValue: totalApplicantsThisMonth.toDouble(),
          startAngle: 180,
          endAngle: 180,
          radiusFactor: 1.0,
          arcColor: green,
          thickness: 0.3,
          value: selectedApplicantsThisMonth.toDouble(),
        ),
        // Inner Teal Arcs
        RadialArc.build(
          isGradient: false,
          maxValue: totalApplicantsPrevMonth.toDouble(),
          startAngle: 20,
          endAngle: 20,
          radiusFactor: 0.6,
          arcColor: tealblue, // Your custom teal color
          thickness: 0.4,
          value: totalApplicantsPrevMonth.toDouble(),
        ),
        RadialArc.build(
          isGradient: false,
          maxValue: totalApplicantsPrevMonth.toDouble(),
          startAngle: 360,
          endAngle: 360,
          radiusFactor: 0.6,
          arcColor: yellow,
          thickness: 0.4,
          value: selectedApplicantsPrevMonth.toDouble(),
        ),
      ],
    );
  }
}
