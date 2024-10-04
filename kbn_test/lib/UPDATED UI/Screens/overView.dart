import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/chartWidget.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/messageWidget.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/payReminder.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/payResult.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/scaffoldBuilder.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/simpleTable.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/verticalTable.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ScaffoldBuilder(
      pageName: "Overview",
      currentPath: "Overview",
      child: SizedBox(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: [
              // First column (Charts and Horizontal Table)
              SizedBox(
                width: size.width > 1200 ? 600 : null,
                child: Column(
                  children: [
                    chartWidget(context),
                    const SizedBox(height: 10),
                    const HorizontalTable(),
                  ],
                ),
              ),

              // Second column (Vertical Table)
              SizedBox(
                width: size.width > 1200 ? (size.width -180) * .33 : null,
                child: VerticalTable(),
              ),

              // Third column (Message and Pay Result)
              SizedBox(
                width: size.width > 1200 ? (size.width -180) * .2 : null,
                child: const Column(
                  children: [
                    MessageWidget(),
                    SizedBox(height: 10),
                    isCompany?PayRemainder():PayResult(),
                    // isCompany ? PayResult() : PayRemainder(),
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
