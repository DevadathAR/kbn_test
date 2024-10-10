// Reusable method to build a generic table
import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/widgets_common/boldText.dart';
import 'package:kbn_test/veiw/widgets_common/boxBTN.dart';
import 'package:kbn_test/veiw/widgets_common/normalText.dart';
import 'package:kbn_test/veiw/widgets_common/statusUpdate.dart';

Widget applicantsTable({
  context,
  required List<Map<String, String>> headers,
  required List<Map<String, String>> data,
  required List<String> statusOptions,
  required String status,
  // required int applicationId,
  onStatusChange,
} // Ad}d callback parameter
    ) {
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
                ...data.asMap().entries.map((entry) {
                  final index = entry.key;
                  final row = entry.value;
                  return TableRow(
                    children: headers.map((header) {
                      if (header['key'] == 'status') {
                        return CustomStatusColumn(
                          status: status,
                          applicationId: int.tryParse(row['id'] ?? '0') ?? 0,
                          onStatusChange: () {
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
    {applicantId,
    status,
    onstatusChange,
    // required double width,
    required List<Map<String, String>> data,
    required String headerTitle,
    List<String>? statusOptions,
    String? path}) {
  List<String> keys = isCompany
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
                  bool hasStatus = row.containsKey('status');
                  return TableRow(
                    children: [
                      ...keys.map((key) => _buildDataCell(row[key] ?? '')),

                      // If the row contains 'status', show the CustomStatusColumn
                      if (hasStatus)
                        CustomStatusColumn(
                          status: status,
                          applicationId: applicantId,
                          onStatusChange: () {
                            onstatusChange;
                          },
                          statusOptions:
                              statusOptions ?? ['Approved', 'Pending'],
                        ),

                      // Otherwise, show the ButtonCell
                      if (!hasStatus) _buildButtonCell(context),
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
  final VoidCallback onStatusChange;
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
      await ApiServices.updateApplication(
          newStatus, widget.applicationId);
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

// Widget for the button cell
Widget _buildButtonCell(context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: BoxButton(
        title: "View Details",
        onTap: () {
          showProfileDialog(context);
        }),
  );
}

void showProfileDialog(BuildContext context) {
  // Fetch applicant details when the dialog is shown
  // ApiServices.fetchApplicantDetails(widget.applicantId);
  showDialog(
    context: context,
    barrierColor: semitransp,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child:
            // isLoading
            //     ? const Center(child: CircularProgressIndicator())
            //     :

            SizedBox(
          width: 400,
          height: 248,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Image and summary row
                Container(
                  width: 202.82,
                  height: 202.82,
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // Background color if no image
                    borderRadius: BorderRadius.circular(8), // Square corners
                    image: const DecorationImage(
                      image: AssetImage(compnyLogo)
                          as ImageProvider, // Use a placeholder if image is null
                      fit: BoxFit.cover, // Adjusts image to cover the container
                    ),
                  ),
                ),

                const SizedBox(width: 10),
                // applicant name and designation
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText(text: 'Name', size: 15),
                    const SizedBox(height: 5),
                    boldText(text: "Designation", size: 15),
                    const SizedBox(height: 5),
                    normalText(text: '8547809771'),
                    const Spacer(),
                    box(
                      width: 118,
                      height: 28,
                      child: GestureDetector(
                        onTap: () => (), // Adding onTap function
                        child: const Center(
                          child: Text(
                            'RESUME',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    box(
                      width: 118,
                      height: 28,
                      child: GestureDetector(
                        onTap: () => (), // Adding onTap function
                        child: const Center(
                          child: Text(
                            'CONTACT VIA MAIL',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: tealblue,
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
