import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/jobScreen.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/showAll_bTn.dart';

import '../../../../service/companyModelClass.dart';

class HorizontalTable extends StatelessWidget {
  final List<JobsPageDatum> jobsData;

  const HorizontalTable({super.key, required this.jobsData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Minimum width required for one data column
    const double minColumnWidth = 80.0;
    const double minHeaderWidth = 80.0;
    const int maxColumns = 7;
    const int minColumns = 3;

    // Define the headers
    // Define headers based on user type (Company or Admin)
    final List<String> headers = isCompany
        ? [
            'Designation',
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
            children: [
              // First row with headers in the first column and job data across other columns
              for (int i = 0; i < headers.length; i++)
                TableRow(
                  children: [
                    _buildHeaderCell(
                        headers[i]), // Place header in first column
                    for (var job in jobsData)
                      _buildDataCell(
                        _getJobFieldData(job, i), // Data in remaining columns
                      ),
                  ],
                ),
            ],
          ),
          ShowAllBtn(onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CompanyJobpage()));
          })
        ],
      ),
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
      padding: const EdgeInsets.all(15.0),
      child: Text(
        text,
        style: AppTextStyle.normalText,
      ),
    );
  }

  // Get job data based on the index of the header
  String _getJobFieldData(JobsPageDatum job, int index) {
    switch (index) {
      case 0:
        return job.designation;
      case 1:
        return job.vacancy.toString();
      case 2:
        return job.selected.toString();
      case 3:
        return job.status.toString();
      default:
        return '';
    }
  }
}
