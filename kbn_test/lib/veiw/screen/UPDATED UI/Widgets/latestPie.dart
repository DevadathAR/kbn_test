import 'package:flutter/material.dart';
import 'package:kbn_test/service/adminMode.dart';
import 'package:kbn_test/service/companymodelClass.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
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
    return RadialAxis(
      minimum: 0,
      maximum: maxValue,
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

    final totalApplicantsThisMonth =
        companyData?.commonData.applicantsTotal.thisMonth;
    final totalApplicantsPrevMonth =
        companyData?.commonData.applicantsTotal.prevMonth;
    final selectedApplicantsThisMonth =
        companyData?.commonData.applicantsSelected.thisMonth;
    final selectedApplicantsPrevMonth =
        companyData?.commonData.applicantsSelected.prevMonth;

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
          maxValue: totalApplicantsThisMonth!.toDouble(),
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
          value: selectedApplicantsThisMonth!.toDouble(),
        ),
        // Inner Teal Arcs
        RadialArc.build(
          isGradient: false,
          maxValue: totalApplicantsPrevMonth!.toDouble(),
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
          value: selectedApplicantsPrevMonth!.toDouble(),
        ),
      ],
    );
  }
}
