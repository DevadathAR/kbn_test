import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/veiw/auth/company_auth/cmpny_login.dart';
import 'package:kbn_test/veiw/screen/AdminScreen/adminHome.dart';
import 'package:kbn_test/veiw/screen/companyScreen/T_&_C.dart';
import 'package:kbn_test/veiw/widgets/boldText.dart';
import 'package:kbn_test/veiw/widgets/boxBTN.dart';
import 'package:kbn_test/veiw/widgets/home_appbar_box.dart';
import 'package:kbn_test/veiw/widgets/normalText.dart';

class CompanyHomePage extends StatefulWidget {
  const CompanyHomePage({super.key});

  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  List<dynamic> applicationsList = submittedApplicantsData['data'];
  // Fetching the data list from the response
  List<dynamic> selectedApplicants =
      selectedApplicantsData['data']; // List to store selected applicants

  // Method to add selected applicant
  void addSelectedApplicant(dynamic applicant) {
    setState(() {
      if (!selectedApplicants.contains(applicant)) {
        selectedApplicants.add(applicant);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        // Enables scrolling for smaller screens
        child: Column(
          children: [
            Image.asset(
              kbnLogo, // Kbn Logo
              height: size.width < 600
                  ? 30
                  : 40, // Adjust logo size for small screens
            ),
            HomeAppBarBox(
              context,
              T_and_C: const companyT_n_C(),
              logOutTo: const CompanyLoginPage(),
              profileImage:
                  "${ApiServices.baseUrl}/${userDetails['user']['profile_image']}",
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 800) {
                    // Wide screen layout
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Section - Applicant Details
                        Expanded(
                          flex: 2,
                          child: CustomTable(
                            headers: const [
                              'Date',
                              'Applicant name',
                              'Location',
                              'Designation',
                              'Resume',
                              'Status'
                            ],
                            rows: applicationsList.map((application) {
                              // Format the date
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(
                                DateTime.parse(application['created_at']),
                              );

                              return CustomTableRow(
                                cells: [
                                  formattedDate, // Application date
                                  application[
                                      'applicantName'], // Applicant name
                                  application['location'], // Location
                                  application['designation'], // Designation
                                  application['resumeLink'] ??
                                      'N/A', // Resume link
                                  CustomStatusColumn(
                                    status: application['status'],
                                    applicationId: application['applicationId'],
                                    onSelect: () => addSelectedApplicant(
                                        application), // Handle select
                                  ), // Status
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Right Section - Selected Applicants
                        Expanded(
                          flex: 1,
                          child: CustomTable(
                            headers: const ['Name', 'Designation', 'Contact'],
                            rows: selectedApplicants.map((applicant) {
                              return CustomTableRow(
                                cells: [
                                  applicant['applicantName'],
                                  applicant['designation'],
                                  const CustomContactColumn(),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Small screen layout
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTable(
                          headers: const [
                            'Date',
                            'Applicant name',
                            'Location',
                            'Designation',
                            'Resume',
                            'Status'
                          ],
                          rows: applicationsList.map((application) {
                            // Format the date
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(
                              DateTime.parse(application['created_at']),
                            );

                            return CustomTableRow(
                              cells: [
                                formattedDate, // Application date
                                application['applicantName'], // Applicant name
                                application['location'], // Location
                                application['designation'], // Designation
                                application['resumeLink'] ??
                                    'N/A', // Resume link
                                CustomStatusColumn(
                                  status: application['status'],
                                  applicationId: application['applicationId'],
                                  onSelect: () => addSelectedApplicant(
                                      application), // Handle select
                                ), // Status
                              ],
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        CustomTable(
                          headers: const ['Name', 'Designation', 'Contact'],
                          rows: selectedApplicants.map((applicant) {
                            return CustomTableRow(
                              cells: [
                                applicant['applicantName'],
                                applicant['designation'],
                                const CustomContactColumn(),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Table Widget
class CustomTable extends StatelessWidget {
  final List<String> headers;
  final List<CustomTableRow> rows;

  const CustomTable({super.key, required this.headers, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: headers.asMap().map((index, _) {
        return MapEntry(index, const FixedColumnWidth(100));
      }),
      children: [
        // Header Row
        TableRow(
          children:
              headers.map((header) => CustomTableHeader(text: header)).toList(),
        ),
        // Data Rows
        ...rows.map((row) => row.buildRow()),
      ],
    );
  }
}

// Custom Table Row Widget
class CustomTableRow {
  final List<dynamic> cells;

  CustomTableRow({required this.cells});

  TableRow buildRow() {
    return TableRow(
      children: cells
          .map((cell) => SizedBox(
                width: 100,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: cell is Widget ? cell : Text(cell.toString()),
                ),
              ))
          .toList(),
    );
  }
}

// Custom Table Header Widget
class CustomTableHeader extends StatelessWidget {
  final String text;

  const CustomTableHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

// // CustomStatusColumn Widget modified to handle onSelect
class CustomStatusColumn extends StatefulWidget {
  final String status;
  final VoidCallback onSelect; // Callback for when Select is pressed
  final int applicationId; // Add the applicationId as a parameter

  const CustomStatusColumn({
    super.key,
    required this.status,
    required this.onSelect,
    required this.applicationId,
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

      if (newStatus == 'SELECTED' || newStatus == 'REJECTED') {
        _updateApplicationStatus(
            widget.applicationId); // Call the update API with applicationId
      }
      if (newStatus == 'SELECTED') {
        widget.onSelect(); // Trigger onSelect when selected
      }
    });
  }

  void _updateApplicationStatus(int applicantionId) async {
    try {
      String newStatus = status; // Example status
      var result =
          await ApiServices.updateApplication(newStatus, applicantionId);
      // Handle the result, for example, show a success message
      print('Application status: $result');
    } catch (e) {
      // Handle the error, for example, show an error message
      print('Failed to update application: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (status != 'REJECTED')
          GestureDetector(
            onTap: () => _setStatus('SELECTED'),
            child: Container(
              width: 80,
              height: 15,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black,
                    width: status == 'SELECTED' ? 0.01 : 0.5),
                borderRadius: BorderRadius.circular(1.0),
              ),
              child: Text(
                status == 'SELECTED' ? 'SELECTED' : 'SELECT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: status == 'SELECTED' ? tealblue : tealblue,
                ),
              ),
            ),
          ),
        const SizedBox(height: 10),
        if (status != 'SELECTED')
          GestureDetector(
            onTap: () => _setStatus('REJECTED'),
            child: Container(
              width: 80,
              height: 15,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black,
                    width: status == 'SELECTED' ? 0.01 : 0.5),
                borderRadius: BorderRadius.circular(1.0),
              ),
              child: Text(
                status == 'REJECTED' ? 'REJECTED' : 'REJECT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: status == 'REJECTED'
                      ? Colors.red
                      : const Color(0xFFEB1D1D), // Color when selected,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class CustomContactColumn extends StatelessWidget {
  const CustomContactColumn({super.key});

  @override
  Widget build(BuildContext context) {
    // used the container as a box widget
    return box(
      height: 15,
      width: 69,
      child: GestureDetector(
        onTap: () => showProfileDialog(context), // Adding onTap function
        child: Container(
          child: const Center(
            child: Text(
              'VIEW DETAILS',
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
    );
  }

  void showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: semitransp,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            width: 516,
            height: 373,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image and summary row
                  Row(
                    children: [
                      // Profile Image
                      Container(
                        width: 210,
                        height: 210,
                        decoration: BoxDecoration(
                          color:
                              Colors.grey[300], // Background color if no image
                          borderRadius:
                              BorderRadius.circular(8), // Square corners
                          image: const DecorationImage(
                            image: AssetImage('assets/profile_image.jpg'),
                            fit: BoxFit
                                .cover, // Adjusts image to cover the container
                          ),
                        ),
                      ),
                      const SizedBox(width: 20), // Space between image and text

                      // Summary and Skills
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            boldText(text: 'Summary', size: 16),
                            // Summary description
                            normalText(text: profileSum),
                            const SizedBox(height: 10),

                            box(
                                width: 215,
                                height: 70,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    boldText(text: 'Skills', size: 13),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // applicant name and designation
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          boldText(text: 'Applicant Name', size: 15),
                          const SizedBox(height: 5),
                          boldText(text: 'Designation', size: 15),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      box(
                        width: 105,
                        height: 25,
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
                      const Spacer(),
                      box(
                        width: 105,
                        height: 25,
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
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
