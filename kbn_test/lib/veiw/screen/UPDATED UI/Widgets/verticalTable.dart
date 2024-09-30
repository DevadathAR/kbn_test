import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/CompanySection/CompanyScaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/showAll_bTn.dart';
import 'package:kbn_test/veiw/widgets_common/boxBTN.dart'; // Make sure your color file path is correct

class VerticalTable extends StatelessWidget {
  const VerticalTable({super.key, });

  @override
  Widget build(BuildContext context) {
    // Define the headers and row data
    final List<String> headers = isCompany
        ? [
            'Applicant name',
            'Dssignation',
            '',
          ]
        : [
            'Company name',
            'Website link',
            '' // Third column for the button
          ];

    // Sample data for the table rows
    final List<List<String>> rowData = [
      ['sandeep', 'link'],
      ['hafees', 'www. hafees.com'],
      ['dev', 'www. dev.com'],
      ['arjun', 'www. arjun.com'],
      ['shalu', 'www. shalu.com'],
    ];

    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), color: white),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder(
                horizontalInside:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
                verticalInside:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
              ),
              columnWidths: const {
                0: FlexColumnWidth(), // Responsive width for company name column
                1: FlexColumnWidth(), // Responsive width for website link column
                2: FixedColumnWidth(
                    120), // Fixed width for the third button column
              },
              children: [
                // Add the header row
                TableRow(
                  children: [
                    _buildHeaderCell(headers[0]), // 'Company name'
                    _buildHeaderCell(headers[1]), // 'Website link'
                    _buildHeaderCell(''), // Empty header for the third column
                  ],
                ),
                // Add the data rows
                for (var row in rowData)
                  TableRow(
                    children: [
                      _buildDataCell(row[0]), // Company name
                      _buildDataCell(row[1]), // Website link
                      _buildButtonCell(), // Button for 'View Details'
                    ],
                  ),
              ],
            ),
            const SizedBox(
                height: 5), // Spacing between table and the "Show all" button
            ShowAllBtn(onTap: () {})
          ],
        ),
      ),
    );
  }

  // Widget for header cell
  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 23.5, horizontal: 5.0), // Increase vertical padding
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Widget for data cell
  Widget _buildDataCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 23.5, horizontal: 5.0), // Increase vertical padding
      child: Text(
        text,
        style: AppTextStyle.normalText,
        textAlign: TextAlign.center,
      ),
    );
  }

  // Widget for the button cell
  Widget _buildButtonCell() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BoxButton(title: "View Details", onTap: () {}),
    );
  }
}
