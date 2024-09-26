import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/scaffoldBuilder.dart';
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
    List<Map<String, String>> headers = [
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
              buildTable(
                screenwidth > 600 ? screenwidth * 0.5 : screenwidth,
                headers,
                tableData,
              ),
              const SizedBox(width: 5),
              buildSelectedApplicantsTable(
                screenwidth > 600 ? screenwidth * 0.3 : screenwidth,
                selectedApplicants,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable method to build a generic table
  Widget buildTable(
    double width,
    List<Map<String, String>> headers,
    List<Map<String, String>> data,
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
              columnWidths: const {
                0: FixedColumnWidth(80.0),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(),
                4: FixedColumnWidth(80.0),
                5: FlexColumnWidth(),
              },
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
                  columnWidths: const {
                    0: FixedColumnWidth(80.0),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                    4: FixedColumnWidth(80.0),
                    5: FlexColumnWidth(),
                  },
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

  // Reusable method to build the selected applicants table
  Widget buildSelectedApplicantsTable(
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

class CustomStatusColumn extends StatefulWidget {
  final String status;
  final VoidCallback onSelect; // Callback for when Select is pressed
  final int applicationId; // Add the applicationId as a parameter
  final VoidCallback onStatusChange; // Callback to refresh data

  // final Function ()?

  const CustomStatusColumn({
    super.key,
    required this.status,
    required this.onSelect,
    required this.applicationId,
    required this.onStatusChange,
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
      children: [
        StatusButton(
          text: 'SELECT',
          textColor: const Color(0xFF138395), // tealblue color
          onTap: () => _setStatus('SELECTED'),
        ),
        const SizedBox(height: 10),
        StatusButton(
          text: 'REJECT',
          textColor: Colors.red,
          onTap: () => _setStatus('REJECTED'),
        ),
      ],
    );
  }
}
