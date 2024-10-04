import 'package:flutter/material.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/commmonTable.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/scaffoldBuilder.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/lists.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/widgets_common/boxBTN.dart';
import 'package:kbn_test/veiw/widgets_common/statusUpdate.dart';


class CompanyApplicantScreen extends StatelessWidget {
  const CompanyApplicantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double screenwidth = size.width;

    // Data for the full table
       final List<Map<String, String>> headers = isCompany
        ? applicantTableheaders
        : companyTableHeaders; // Different headers for company/admin
    final List<Map<String, String>> data =
        isCompany ? applicantsData : companyTableData;
    // Headers for the full table
    // List<Map<String, String>> applicantTableheaders = [
    //   {'header': 'Date', 'key': 'date'},
    //   {'header': 'Applicant name', 'key': 'name'},
    //   {'header': 'Location', 'key': 'location'},
    //   {'header': 'Designation', 'key': 'designation'},
    //   {'header': 'Resume', 'key': 'resume'},
    //   {'header': 'Status', 'key': 'status'},
    // ];

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
              applicantsTable(context,
                  // screenwidth > 900 ? screenwidth* 0.49 : screenwidth,
                  applicantTableheaders,
                  data,
                  ["SELECT", "REGECT"]),
              const SizedBox(width: 5),
              selectedApplicantsTable(context,
              // width:   screenwidth > 1200 ?screenwidth * 0.49 : screenwidth,
                
                data:   isCompany ? selectedApplicants : apprvedCompanies,
              headerTitle:   isCompany ? "Selected Applicants" : "To Approve",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable method to build the selected applicants table
  Widget selectedApplicantsTable(context,
    {
      // required double width,
    required List<Map<String, String>> data,
    required String headerTitle,
    List<String>? statusOptions,
    String? path}) {
  // Determine the keys based on the conditions
  List<String> keys = isCompany
//applicant screen header
      ? ['name', 'designation']
      : path == "Transactions"
          ? [
              'name',
              'amount',
              'payment',
              'status'
            ] // Path is "Transactions" and it's not a company
          //companies Screen header
          : ['name', 'website']; // Not a company and path is not "Transactions"
          Size size = MediaQuery.of(context).size;

  return Container(
      width: size.width>1200? (size.width-200)*0.49:null,
    height: 500,
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
          },
          children: [
            // Single Header row with empty cells to match the number of columns
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 23.5, horizontal: 5.0),
                  // Header Declaration
                  child: Text(
                    headerTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
        // Data Row Scrollable
        Expanded(
          child: SingleChildScrollView(
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder(
                horizontalInside:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
                verticalInside:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
              ),
              columnWidths: _generateColumnWidths(keys.length),
              children: [
                // Iterating over data rows
                ...data.map((row) {
                  bool hasStatus = row.containsKey('status');
                  return TableRow(
                    children: [
                      ...keys.map((key) => _buildDataCell(row[key] ?? '')),

                      // If the row contains 'status', show the CustomStatusColumn
                      if (hasStatus)
                        CustomStatusColumn(
                          status: row['status'] ?? '',
                          onSelect: () {
                            // Implement the action for select button
                            print(
                                'Select pressed for application ID: ${row['applicationId']}');
                          },
                          applicationId:
                              int.tryParse(row['applicationId'] ?? '0') ?? 0,
                          onStatusChange: () {},
                          statusOptions:
                              statusOptions ?? ['Approved', 'Rejected'],
                        ),
                      // Otherwise, show the ButtonCell
                      if (!hasStatus) _buildButtonCell(),
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
  Map<int, TableColumnWidth> _generateColumnWidths(int headerCount) {
  Map<int, TableColumnWidth> columnWidths = {};
  for (int i = 0; i < headerCount; i++) {
    columnWidths[i] =
        const FlexColumnWidth(); // Adjustable width for each column
  }
  return columnWidths;
}
}