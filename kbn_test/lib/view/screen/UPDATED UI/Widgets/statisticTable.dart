import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kbn_test/service/adminMode.dart';
import 'package:kbn_test/service/companymodelClass.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/view/auth/logInPage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/view/screen/UPDATED%20UI/Widgets/colorDeclaration.dart';

class Statisticpagetable extends StatefulWidget {
  final List<Recruitment>? recruitmentData;
  final List<Performance>? performanceData;

  const Statisticpagetable({
    super.key,
    this.recruitmentData,
    this.performanceData,
  });

  @override
  _StatisticpagetableState createState() => _StatisticpagetableState();
}

class _StatisticpagetableState extends State<Statisticpagetable> {
  final GlobalKey _globalKey = GlobalKey();

  // Define the headers and row data
  final List<String> headers = ['Name', 'Percentage'];

  Future<void> shareTableText() async {
    // Start with the headers
    String tableText = '${headers.join('\t-')}\n';

    if (isCompany) {
      for (var recruitment in widget.recruitmentData ?? []) {
        tableText +=
            '${recruitment.jobTitle}\t-\t${recruitment.currentMonth ?? 0}%\n';
      }
    } else {
      for (var performance in widget.performanceData ?? []) {
        tableText +=
            '${performance.companyName}\t-\t${performance.performancePercentageThisMonth ?? 0}%\n';
      }
    }
    // Share the constructed tableText
    await Share.share(tableText);
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> tableRows = [];

    if (isCompany) {
      // Handle recruitment data
      for (var i = 0; i < 6; i++) {
        if (i < (widget.recruitmentData?.length ?? 0)) {
          var recruitment = widget.recruitmentData![i];
          tableRows.add(
            TableRow(
              children: [
                _buildDataCell(recruitment.jobTitle ?? 'N/A'),
                _buildDataCell('${recruitment.currentMonth ?? 0}%'),
              ],
            ),
          );
        } else {
          // Add empty rows with 0 values
          tableRows.add(
            TableRow(
              children: [
                _buildDataCell('N/A'),
                _buildDataCell('0%'),
              ],
            ),
          );
        }
      }
    } else {
      // Handle performance data
      for (var i = 0; i < 6; i++) {
        if (i < (widget.performanceData?.length ?? 0)) {
          var performance = widget.performanceData![i];
          tableRows.add(
            TableRow(
              children: [
                _buildDataCell(performance.companyName ?? 'N/A'),
                _buildDataCell(
                    '${performance.performancePercentageThisMonth ?? 0}%'),
              ],
            ),
          );
        } else {
          // Add empty rows with 0 values
          tableRows.add(
            TableRow(
              children: [
                _buildDataCell('N/A'),
                _buildDataCell('0%'),
              ],
            ),
          );
        }
      }
    }

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                colorDeclaration(title: previousMonth),
                colorDeclaration(title: currentMonth),
              ],
            ),
            const SizedBox(height: 5),
            RepaintBoundary(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Fixed header
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 0.5,
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(),
                    },
                    children: [
                      TableRow(
                        children: headers
                            .map((header) => _buildHeaderCell(header))
                            .toList(),
                      ),
                    ],
                  ),

                  // Scrollable data
                  SizedBox(
                    height: 300, // Set height for scrollable content
                    child: SingleChildScrollView(
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 0.5,
                        ),
                        columnWidths: const {
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),
                        },
                        children: tableRows,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: shareTableText,
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      color: tealblue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: SvgPicture.asset(
                      shareIcon,
                      width: 10,
                      height: 10,
                      color: white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 23.5, horizontal: 5.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 8,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDataCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 23.5, horizontal: 5.0),
      child: Text(
        text,
        style: AppTextStyle.normalText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
