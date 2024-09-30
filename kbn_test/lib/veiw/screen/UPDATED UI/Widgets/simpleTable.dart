import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/CompanySection/CompanyScaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/showAll_bTn.dart';

class HorizontalTable extends StatelessWidget {
  const HorizontalTable({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Minimum width required for one data column
    const double minColumnWidth = 80.0;
    const double minHeaderWidth = 70.0;
    const int maxColumns = 7;
    const int minColumns = 3;

    // Define the headers
    // Define headers based on user type (Company or Admin)
    final List<String> headers = isCompany
        ? [
            'Job name',
            'Vacancy',
            'Selected',
            'Status',
          ]
        : [
            'Company name',
            'Vacancy',
            'Selected',
            'Status',
          ];

    // Calculate how many columns can fit in the available screen width
    int columnCount = ((screenWidth - minHeaderWidth) ~/ minColumnWidth)
        .clamp(minColumns, maxColumns);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), color: white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Table(
            border: TableBorder(
              horizontalInside:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
              verticalInside:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
            ),
            columnWidths: {
              0: const FixedColumnWidth(
                  minHeaderWidth), // Fixed width for the header column
              for (int i = 1; i <= columnCount; i++)
                i: const FlexColumnWidth(), // Responsive width for other columns
            },
            children: List.generate(
              headers.length,
              (index) {
                return _buildTableRow(headers[index], index + 1, columnCount);
              },
            ),
          ),
          ShowAllBtn(onTap: () {})
          // ElevatedButton(onPressed: () {}, child: const Text("ShowAll"))
        ],
      ),
    );
  }

  TableRow _buildTableRow(String header, int rowIndex, int columnCount) {
    return TableRow(
      children: [
        _buildHeaderCell(header),
        for (int i = 0; i < columnCount; i++)
          _buildDataCell('Data $rowIndex.$i'),
      ],
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDataCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        text,
        style: AppTextStyle.normalText,
      ),
    );
  }
}
