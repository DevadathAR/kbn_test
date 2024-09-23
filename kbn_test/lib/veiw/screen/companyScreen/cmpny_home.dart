import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/screen/companyScreen/T_&_C.dart';
import 'package:kbn_test/veiw/screen/companyScreen/companyProfile.dart';
import 'package:kbn_test/veiw/widgets_common/boldText.dart';
import 'package:kbn_test/veiw/widgets_common/boxBTN.dart';
import 'package:kbn_test/veiw/widgets_common/home_appbar_box.dart';
import 'package:kbn_test/veiw/widgets_common/normalText.dart';
import 'package:kbn_test/veiw/widgets_common/statusUpdate.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _checkAndShowDialog();

    _fetchApplicantsData(); // Fetch data when widget is initialized

    super.initState();
  }

  Future<void> setDialogShown(bool shown) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('warning_dialog_shown', shown);
  }

  Future<bool> isDialogShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('warning_dialog_shown') ?? false;
  }

  Future<void> _checkAndShowDialog() async {
    bool dialogShown = await isDialogShown();

    if (!dialogShown) {
      var kbnCode = userDetails['user']['kbn_code'];
      bool isApproved = kbnCode != null;

      if (!isApproved) {
        approvalWarning(context);
        await setDialogShown(true); // Mark the dialog as shown
      }
    }
  }

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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 800) {
                    // Wide screen layout
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left Section - Applicant Details
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: size.height * 0.8,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
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
                          ),
                        ),
                        const SizedBox(width: 5),
                        // Right Section - Selected Applicants
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: size.height * 0.8,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: CustomTable(
                                headers: const [
                                  'Name',
                                  'Designation',
                                  'Contact'
                                ],
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
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Small screen layout
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // small Layout first Table

                        SizedBox(
                          height: size.height * 0.4,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
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
                                    ), // Status
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // small Layout second Table
                        SizedBox(
                          height: size.height * 0.4,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: CustomTable(
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
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTable extends StatelessWidget {
  final List<String> headers;
  final List<CustomTableRow> rows;

  const CustomTable({super.key, required this.headers, required this.rows});

  @override
  Widget build(BuildContext context) {
    // Get the total screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate dynamic column width based on screen size
    double columnWidth = screenWidth < 600
        ? screenWidth / headers.length // For mobile, distribute evenly
        : screenWidth /
            (headers.length * 3); // Wider screens, adjust column width

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Table(
          border: TableBorder.all(),
          columnWidths: headers.asMap().map((index, _) {
            // Use the calculated column width for each column
            return MapEntry(index, FixedColumnWidth(columnWidth));
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
                width: 50,
                height: 60,
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

void approvalWarning(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: semitransp,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: none, // Transparent dialog background
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Colors.transparent, // Transparent dialog content background
            border: Border.all(color: Colors.transparent), // No border color
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'If you are new here, you must have approval for your company from the admin side.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white, // Text color
                ),
              ),
              const SizedBox(height: 60.0), // 30 dp gap
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: none, // Button background color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0), // Adjust padding as needed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Adjust border radius as needed
                  ),
                ),
                child: const Text('Back Home'),
              )
            ],
          ),
        ),
      );
    },
  );
}
