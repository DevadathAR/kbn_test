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
    Size size = MediaQuery.of(context).size;

    return ScaffoldBuilder(
      pageName: "Overview",
      currentPath: "Overview",
      child: SizedBox(
        // height: 410,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: [
              // First column (Charts and Horizontal Table)
              SizedBox(
                // width: size.width>600? 500:null,
                width: size.width > 1200
                    ? 600
                    // size.width * .3
                    : null,

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
                // width: 400, // Adjust the width as necessary
                // width: size.width>1650? 500:null,
                width: size.width > 1200 ? size.width * .3 : null,

                child: VerticalTable(),
              ),

              // Third column (Message and Pay Result)
              SizedBox(
                // width: 400, // Adjust the width as necessary
                // width: size.width>1650? 450:null,
                width: size.width > 1200 ? size.width * .2 : null,

                child: const Column(
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
