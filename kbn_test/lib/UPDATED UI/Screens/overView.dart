import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/chartWidget.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/messageWidget.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/payResult.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/scaffoldBuilder.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/simpleTable.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/verticalTable.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldBuilder(
      pageName: "Overview",
      currentPath: "Overview",
      child: SizedBox(
        height: 410,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Wrap(
            spacing: 10.0, 
            runSpacing: 10.0, 
            children: [
              // First column (Charts and Horizontal Table)
              SizedBox(
                width: 400, 
                child: Column(
                  children: [
                    ChartWidget(),
                    SizedBox(height: 10),
                    HorizontalTable(),
                  ],
                ),
              ),

              // Second column (Vertical Table)
              SizedBox(
                width: 400, // Adjust the width as necessary
                child: VerticalTable(),
              ),

              // Third column (Message and Pay Result)
              SizedBox(
                width: 400, // Adjust the width as necessary
                child: Column(
                  children: [
                    MessageWidget(),
                    SizedBox(height: 10),
                    PayResult(),
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
