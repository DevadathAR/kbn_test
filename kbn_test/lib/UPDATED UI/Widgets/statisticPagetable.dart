import 'package:flutter/material.dart';
import 'package:kbn_test/UPDATED%20UI/Screens/applicantsScreen.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/showAll_bTn.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

class Statisticpagetable extends StatelessWidget {
  const Statisticpagetable({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the headers and row data
    final List<String> headers = [
      'Name',
      'Percentage',
    ];

    // Sample data for the table rows
    final List<List<String>> rowData = [
      ['Tile A', '25%'],
      ['Tile B', '40%'],
      ['Tile C', '15%'],
      ['Tile D', '10%'],
      ['Tile E', '50%'],
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
                0: FlexColumnWidth(), // Responsive width for Tile Name column
                1: FlexColumnWidth(), // Responsive width for Percentage column
              },
              children: [
                // Add the header row
                TableRow(
                  children: [
                    _buildHeaderCell(headers[0]), // 'Tile Name'
                    _buildHeaderCell(headers[1]), // 'Percentage'
                  ],
                ),
                // Add the data rows
                for (var row in rowData)
                  TableRow(
                    children: [
                      _buildDataCell(row[0]), // Tile Name
                      _buildDataCell(row[1]), // Percentage
                    ],
                  ),
              ],
            ),
            const SizedBox(
                height: 5), // Spacing between table and the "Show all" button
            ShowAllBtn(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const TwoTablesScreen();
                }));
              },
              title: "arrow mark for share table img",
            )
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
}
