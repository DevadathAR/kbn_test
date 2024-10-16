// Reusable method to build a generic table
import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/dialogueBoxes.dart';
import 'package:kbn_test/veiw/widgets_common/boldText.dart';
import 'package:kbn_test/veiw/widgets_common/boxBTN.dart';
import 'package:kbn_test/veiw/widgets_common/normalText.dart';
import 'package:kbn_test/veiw/widgets_common/statusUpdate.dart';

Widget applicantsTable({
  context,
  required List<Map<String, String>> headers,
  required List<String> statusOptions,
  required String status,
  List<Map<String, String>>? Data,
  // List<Map<String, String>>? companiesData,

  required Function(int applicationId)
      onStatusChange, // Add callback with applicationId parameter
}) {
  Size size = MediaQuery.of(context).size;
  return Container(
    width: size.width > 1200 ? (size.width - 200) * 0.49 : null,
    height: 400,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: Column(
      children: [
        // Header row
        Table(
          border: tableHeaderDec(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: _generateColumnWidths(headers.length),
          children: [
            TableRow(
              children: headers.map((header) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18.5,
                    horizontal: 5.0,
                  ),
                  child: Text(
                    header['header']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        // Data rows
        Expanded(
          child: SingleChildScrollView(
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder(
                horizontalInside: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 0.5,
                ),
                verticalInside: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 0.5,
                ),
              ),
              columnWidths: _generateColumnWidths(headers.length),
              children: [
                ...Data!.asMap().entries.map((entry) {
                  final index = entry.key;
                  final row = entry.value;
                  return TableRow(
                    children: headers.map((header) {
                      if (header['key'] == 'status') {
                        return CustomStatusColumn(
                          status: status,
                          applicationId: int.tryParse(row['id'] ?? '0') ?? 0,
                          onStatusChange: (updatedStatus) {
                            onStatusChange(int.tryParse(row['id'] ?? '0') ?? 0);
                          },
                          statusOptions: statusOptions,
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 23.5,
                            horizontal: 5.0,
                          ),
                          child: Text(
                            row[header['key']] ?? '',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.normalText,
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
    ),
  );
}

Widget selectedApplicantsTable(context,
    {
    status,
    onstatusChange,
    required VoidCallback onAdminAproval,
    // required double width,
    required List<Map<String, String>> data,
    required String headerTitle,
    List<String>? statusOptions,
    String? path}) {
  List<String> keys = isCompany ? ['name', 'designation'] : ['name', 'website'];
  Size size = MediaQuery.of(context).size;

  return Container(
    width: size.width > 1200 ? (size.width - 200) * 0.49 : null,
    height: 400,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: white,
    ),
    child: Column(
      children: [
        // header
        Table(
          border: tableHeaderDec(),
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
                  return TableRow(
                    children: [
                      ...keys.map((key) => _buildDataCell(row[key] ?? '')),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: BoxButton(
                            title: "View Details",
                            onTap: () {
                              isCompany
                                  ? showApplicantProfile(
                                      designation: row['designation'] ?? '',
                                      applicantId:
                                          int.tryParse(row['id'] ?? '0') ?? 0,
                                      context: context,
                                    )
                                  : showCompanyProfileDialog(
                                      context: context,
                                      companyId:
                                          int.tryParse(row['id'] ?? '0') ?? 0,
                                      onApproval: () {
                                        onAdminAproval();
                                      },
                                    );
                            }),
                      ),
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
  final int applicationId;
  final Function(String newStatus) onStatusChange; // Updated callback signature
  final List<String> statusOptions;

  const CustomStatusColumn({
    super.key,
    required this.status,
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
    status = widget.status; // Initialize the status with the passed value
  }

  void _setStatus(String newStatus) async {
    setState(() {
      status = newStatus;
    });
    // Proceed with the API call
    try {
      await ApiServices.updateApplicationStatus(
          newStatus, widget.applicationId);

      widget.onStatusChange(newStatus); // Call the callback with the new status
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
              textColor: index == 0 ? Colors.teal : Colors.red,
              onTap: () =>
                  _setStatus("${option}ED"), // Update status when clicked
            ),
            const SizedBox(height: 10),
          ],
        );
      }).toList(),
    );
  }
}

TableBorder tableHeaderDec() {
  return TableBorder(
    bottom: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
    horizontalInside:
        BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
    verticalInside: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
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
