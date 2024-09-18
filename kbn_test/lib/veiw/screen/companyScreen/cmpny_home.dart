import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/veiw/auth/company_auth/cmpny_login.dart';
import 'package:kbn_test/veiw/screen/companyScreen/T_&_C.dart';
import 'package:kbn_test/veiw/screen/companyScreen/companyProfile.dart';
import 'package:kbn_test/veiw/widgets/boldText.dart';
import 'package:kbn_test/veiw/widgets/boxBTN.dart';
import 'package:kbn_test/veiw/widgets/home_appbar_box.dart';
import 'package:kbn_test/veiw/widgets/normalText.dart';
import 'package:kbn_test/veiw/widgets/statusUpdate.dart';

class CompanyHomePage extends StatefulWidget {
  const CompanyHomePage({super.key});

  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  List<dynamic> applicationsList = [];
  List<dynamic> selectedApplicants = [];

  @override
  void initState() {
    // _fetchUserData();
    _fetchApplicantsData(); // Fetch data when widget is initialized

    super.initState();
  }

  // Future<void> _fetchUserData() async {
  //   var userDetailsResponse = await ApiServices.fetchUserDetails();
  //   userDetails = userDetailsResponse;
  // }

  // Method to fetch applicants data
  Future<void> _fetchApplicantsData() async {
    try {
      // print(userDetails);

      // Fetch the latest submitted and selected applicants data
      var newSelectedApplicantsData = await ApiServices.fetchSelectedApplctns();
      var newSubmittedApplicantsData =
          await ApiServices.fetchSubmittedApplctns();

      setState(() {
        applicationsList = newSubmittedApplicantsData['data'];
        selectedApplicants = newSelectedApplicantsData['data'];
      });
    } catch (e) {
      print('Error fetching applicant data: $e');
    }
  }

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
      body: Column(
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
            // logOutTo: const CompanyLoginPage(),
            profilePage: const CompanyProfilePage(),
            home: const CompanyHomePage(),
            profileImage:
                "${ApiServices.baseUrl}/${userDetails['user']['profile_image']}",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
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
                                      applicationId:
                                          application['applicationId'],
                                      onSelect: () {
                                        addSelectedApplicant(
                                            application['applicationId']);
                                      },
                                      onStatusChange: _fetchApplicantsData,
                                    ) // Status
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
                                    CustomContactColumn(
                                      designation: applicant['designation'],
                                      applicantId: applicant['userId'],
                                    ),
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
                                  application[
                                      'applicantName'], // Applicant name
                                  application['location'], // Location
                                  application['designation'], // Designation
                                  application['resumeLink'] ??
                                      'N/A', // Resume link
                                  CustomStatusColumn(
                                    status: application['status'],
                                    applicationId: application['applicationId'],
                                    onSelect: () {
                                      addSelectedApplicant(
                                          application['applicationId']);
                                    },
                                    onStatusChange: _fetchApplicantsData,
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
                                  CustomContactColumn(
                                      designation: applicant['designation'],
                                      applicantId: applicant['userId']),
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
            ),
          ),
        ],
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(),
        columnWidths: headers.asMap().map((index, _) {
          return MapEntry(index, const FixedColumnWidth(100));
        }),
        children: [
          // Header Row
          TableRow(
            children: headers
                .map((header) => CustomTableHeader(text: header))
                .toList(),
          ),
          // Data Rows
          ...rows.map((row) => row.buildRow()),
        ],
      ),
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

  void _setStatus(String newStatus) async {
    setState(() {
      status = newStatus;
    });
    // Proceed with the API call
    try {
      await ApiServices.updateApplication(newStatus, widget.applicationId);
      widget.onStatusChange();
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  Future<void> _updateApplicationStatus(int applicantionId) async {
    try {
      String newStatus = status;
      var result =
          await ApiServices.updateApplication(newStatus, applicantionId);
      widget.onStatusChange(); // Refresh data

      print('Application status updated: $result');
//............................................................................................
    } catch (e) {
      // SnackBar(content: Text('Failed to update application: $e')),

      print('Failed to update application: $e');
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

class CustomContactColumn extends StatefulWidget {
  final int applicantId;
  final String designation;
  const CustomContactColumn(
      {super.key, required this.applicantId, required this.designation});

  @override
  State<CustomContactColumn> createState() => _CustomContactColumnState();
}

class _CustomContactColumnState extends State<CustomContactColumn> {
  Map<String, dynamic>? applicantDetails; // Stores fetched details
  bool isLoading = true; // To manage loading state

  @override
  void initState() {
    super.initState();
    // Moved fetchDetails call to be triggered initially
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    try {
      var details = await ApiServices.fetchApplicantDetails(widget.applicantId);

      // print('viewsdDetails$details');
      setState(() {
        applicantDetails = details;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error appropriately
      print('Failed to load applicant details: $e');
    }
  }

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
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
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
                            color: Colors
                                .grey[300], // Background color if no image
                            borderRadius:
                                BorderRadius.circular(8), // Square corners
                            image: DecorationImage(
                              image: applicantDetails?['user']
                                          ['profile_image'] !=
                                      null
                                  ? NetworkImage(
                                      "${ApiServices.baseUrl}/${applicantDetails?['user']['profile_image']}")
                                  : const AssetImage(compnyLogo)
                                      as ImageProvider, // Use a placeholder if image is null
                              fit: BoxFit
                                  .cover, // Adjusts image to cover the container
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),
                        // applicant name and designation
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            boldText(
                                text:
                                    applicantDetails?['user']['name'] ?? 'N/A',
                                size: 15),
                            const SizedBox(height: 5),
                            boldText(text: widget.designation, size: 15),
                            const SizedBox(height: 5),
                            normalText(
                                text: applicantDetails?['user']['contact'] ??
                                    'N/A'),
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
}
