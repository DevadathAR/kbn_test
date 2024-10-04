  // Reusable method to build a generic table
  import 'package:flutter/material.dart';
import 'package:kbn_test/UPDATED%20UI/Screens/applicantsScreen.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/veiw/widgets_common/statusUpdate.dart';

Widget applicantsTable(
  context,
  
    // double width,
    List<Map<String, String>> headers,
    List<Map<String, String>> data,
    List<String> statusOptions, // Add status options dynamically
  ) {
          Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width>1200? (size.width-200)*0.49:null,
        height: 500,

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