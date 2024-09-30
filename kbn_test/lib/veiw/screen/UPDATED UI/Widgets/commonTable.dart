// Reusable method to build a generic table
import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/CompanySection/CompanyScaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/widgets_common/boxBTN.dart';
import 'package:kbn_test/veiw/widgets_common/statusUpdate.dart';

Widget applicantsTable(
  double width,
  List<Map<String, String>> headers,
  List<Map<String, String>> data,
  List<String> statusOptions, // Add status options dynamically
) {
  return Container(
      width: width,
      height: 400,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: white,
      ),
      child: Column(
        children: [
          // Header row (fixed)
          Table(
            border: TableBorder(
              horizontalInside:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
              verticalInside:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
            ),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths:
                _generateColumnWidths(headers.length), // Dynamic widths

            children: [
              TableRow(
                children: headers.map((header) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 23.5, horizontal: 5.0),
                    child: Text(
                      header['header']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          // Data rows (scrollable)
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
                columnWidths:
                    _generateColumnWidths(headers.length), // Dynamic widths

                children: [
                  ...data.asMap().entries.map((entry) {
                    final index = entry.key;
                    final row = entry.value;
                    return TableRow(
                      children: headers.map((header) {
                        if (header['key'] == 'status') {
                          // Use the custom status widget in the 'status' column
                          return CustomStatusColumn(
                            status: row['status'] ?? '',
                            applicationId:
                                index, // Assuming the index is used as the applicationId
                            onSelect: () {
                              print('Status selected for application $index');
                            },
                            onStatusChange: () {
                              // Define logic to handle status change and refresh
                            },
                            statusOptions: statusOptions,
                          );
                        } else {
                          // Default data cell for other columns
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 23.5, horizontal: 5.0),
                            child: Text(
                              row[header['key']] ?? '',
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                      }).toList(),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ));
}

/// Helper function to generate column widths based on the number of headers
Map<int, TableColumnWidth> _generateColumnWidths(int headerCount) {
  Map<int, TableColumnWidth> columnWidths = {};
  for (int i = 0; i < headerCount; i++) {
    columnWidths[i] =
        const FlexColumnWidth(); // Adjustable width for each column
  }
  return columnWidths;
}

class CustomStatusColumn extends StatefulWidget {
  final String status;
  final VoidCallback onSelect; // Callback for when Select is pressed
  final int applicationId;
  final VoidCallback onStatusChange; // Callback to refresh data
  final List<String> statusOptions; // List of status options to show

  // final Function ()?

  const CustomStatusColumn({
    super.key,
    required this.status,
    required this.onSelect,
    required this.applicationId,
    required this.onStatusChange,
    required this.statusOptions,
  });

  @override
  _CustomStatusColumnState createState() => _CustomStatusColumnState();
}

class _CustomStatusColumnState extends State<CustomStatusColumn> {
  String status = '';

  @override
  void initState() {
    super.initState();
    status = widget.status;
  }

  void _setStatus(String newStatus) {
    setState(() {
      status = newStatus;
    });
    // Proceed with the API call
    try {
      // await ApiServices.updateApplication(newStatus, widget.applicationId);
      widget.onStatusChange();
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.statusOptions.asMap().entries.map((entry) {
        int index = entry.key;
        String option = entry.value;
        return Column(
          children: [
            StatusButton(
              text: option,
              textColor: index == 0 ? tealblue : Colors.red,
              onTap: () => _setStatus(option),
            ),
            const SizedBox(height: 10),
          ],
        );
      }).toList(),
    );
  }
}

Widget selectedApplicantsTable(
    {required double width,
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
