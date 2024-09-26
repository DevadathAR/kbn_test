import 'package:flutter/material.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/commmonTable.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/scaffoldBuilder.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/widgets_common/boxBTN.dart';
import 'package:kbn_test/veiw/widgets_common/statusUpdate.dart';


class TwoTablesScreen extends StatelessWidget {
  const TwoTablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double screenwidth = size.width;

    // Data for the full table
    List<Map<String, String>> tableData = [
      {
        'date': '2023-09-24',
        'name': 'John Doe',
        'location': 'New York',
        'designation': 'Developer',
        'resume': 'View',
        'status': 'SELECTED',
      },
      {
        'date': '2023-09-25',
        'name': 'Jane Smith',
        'location': 'Los Angeles',
        'designation': 'Designer',
        'resume': 'View',
        'status': 'REJECTED',
      },
      {
        'date': '2023-09-24',
        'name': 'John Doe',
        'location': 'New York',
        'designation': 'Developer',
        'resume': 'View',
        'status': 'SELECTED',
      },
      {
        'date': '2023-09-25',
        'name': 'Jane Smith',
        'location': 'Los Angeles',
        'designation': 'Designer',
        'resume': 'View',
        'status': 'REJECTED',
      },
      {
        'date': '2023-09-24',
        'name': 'John Doe',
        'location': 'New York',
        'designation': 'Developer',
        'resume': 'View',
        'status': 'SELECTED',
      },
      {
        'date': '2023-09-25',
        'name': 'Jane Smith',
        'location': 'Los Angeles',
        'designation': 'Designer',
        'resume': 'View',
        'status': 'REJECTED',
      },
      {
        'date': '2023-09-24',
        'name': 'John Doe',
        'location': 'New York',
        'designation': 'Developer',
        'resume': 'View',
        'status': 'SELECTED',
      },
      {
        'date': '2023-09-25',
        'name': 'Jane Smith',
        'location': 'Los Angeles',
        'designation': 'Designer',
        'resume': 'View',
        'status': 'REJECTED',
      },
      {
        'date': '2023-09-24',
        'name': 'John Doe',
        'location': 'New York',
        'designation': 'Developer',
        'resume': 'View',
        'status': 'SELECTED',
      },
      {
        'date': '2023-09-25',
        'name': 'Jane Smith',
        'location': 'Los Angeles',
        'designation': 'Designer',
        'resume': 'View',
        'status': 'REJECTED',
      },
      {
        'date': '2023-09-24',
        'name': 'John Doe',
        'location': 'New York',
        'designation': 'Developer',
        'resume': 'View',
        'status': 'SELECTED',
      },
      {
        'date': '2023-09-25',
        'name': 'Jane Smith',
        'location': 'Los Angeles',
        'designation': 'Designer',
        'resume': 'View',
        'status': 'REJECTED',
      },
      {
        'date': '2023-09-24',
        'name': 'John Doe',
        'location': 'New York',
        'designation': 'Developer',
        'resume': 'View',
        'status': 'SELECTED',
      },
      {
        'date': '2023-09-25',
        'name': 'Jane Smith',
        'location': 'Los Angeles',
        'designation': 'Designer',
        'resume': 'View',
        'status': 'REJECTED',
      },
      {
        'date': '2023-09-24',
        'name': 'John Doe',
        'location': 'New York',
        'designation': 'Developer',
        'resume': 'View',
        'status': 'SELECTED',
      },
      {
        'date': '2023-09-25',
        'name': 'Jane Smith',
        'location': 'Los Angeles',
        'designation': 'Designer',
        'resume': 'View',
        'status': 'REJECTED',
      },
      {
        'date': '2023-09-24',
        'name': 'John Doe',
        'location': 'New York',
        'designation': 'Developer',
        'resume': 'View',
        'status': 'SELECTED',
      },
      {
        'date': '2023-09-25',
        'name': 'Jane Smith',
        'location': 'Los Angeles',
        'designation': 'Designer',
        'resume': 'View',
        'status': 'REJECTED',
      },
    ];

    // Data for the selected applicants table
    List<Map<String, String>> selectedApplicants = [
      {
        'name': 'John Doe',
        'designation': 'Developer',
      },
      {
        'name': 'Jane Smith',
        'designation': 'Designer',
      },
      {
        'name': 'John Doe',
        'designation': 'Developer',
      },
      {
        'name': 'Jane Smith',
        'designation': 'Designer',
      },
      {
        'name': 'John Doe',
        'designation': 'Developer',
      },
      {
        'name': 'Jane Smith',
        'designation': 'Designer',
      },
      {
        'name': 'John Doe',
        'designation': 'Developer',
      },
      {
        'name': 'Jane Smith',
        'designation': 'Designer',
      },
      {
        'name': 'John Doe',
        'designation': 'Developer',
      },
      {
        'name': 'Jane Smith',
        'designation': 'Designer',
      },
      {
        'name': 'John Doe',
        'designation': 'Developer',
      },
      {
        'name': 'Jane Smith',
        'designation': 'Designer',
      },
    ];

    // Headers for the full table
    List<Map<String, String>> applicantTableheaders = [
      {'header': 'Date', 'key': 'date'},
      {'header': 'Applicant name', 'key': 'name'},
      {'header': 'Location', 'key': 'location'},
      {'header': 'Designation', 'key': 'designation'},
      {'header': 'Resume', 'key': 'resume'},
      {'header': 'Status', 'key': 'status'},
    ];

    return ScaffoldBuilder(
      currentPath: "Applicants",
      pageName: "Applicants",
      child: SizedBox(
        height: 420,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              applicantsTable(
                  screenwidth > 600 ? screenwidth * 0.5 : screenwidth,
                  applicantTableheaders,
                  tableData,
                  ["SELECT", "REGECT"]),
              const SizedBox(width: 5),
              selectedApplicantsTable(
                screenwidth > 600 ? screenwidth * 0.3 : screenwidth,
                selectedApplicants,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable method to build the selected applicants table
  Widget selectedApplicantsTable(
    double width,
    List<Map<String, String>> data,
  ) {
    // Column keys for the selected applicants
    List<String> keys = ['name', 'designation'];

    return Container(
      width: width,
      height: 400,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: white,
      ),
      child: Column(
        children: [
          Table(
            border: TableBorder(
              horizontalInside:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
              verticalInside:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
            ),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FlexColumnWidth(),
              // 1: FlexColumnWidth(),
              // 2: FlexColumnWidth(),
            },
            children: const [
              // Single Header row with empty cells to match the number of columns
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 23.5, horizontal: 5.0), //
                    child: Text(
                      'Selected Applicants',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // SizedBox(), // Empty cell to match the column count
                  // SizedBox(), // Empty cell to match the column count
                ],
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder(
                  horizontalInside: BorderSide(
                      color: Colors.grey.withOpacity(0.5), width: 0.5),
                  verticalInside: BorderSide(
                      color: Colors.grey.withOpacity(0.5), width: 0.5),
                ),
                columnWidths: const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                },
                children: [
                  // Data rows with 3 columns: name, designation, contact
                  ...data.map((row) {
                    return TableRow(
                      children: [
                        ...keys.map((key) => _buildDataCell(row[key] ?? '')),
                        _buildButtonCell(), // Button column added here
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
      padding: const EdgeInsets.all(10.0),
      child: BoxButton(title: "View Details", onTap: () {}),
    );
  }
}