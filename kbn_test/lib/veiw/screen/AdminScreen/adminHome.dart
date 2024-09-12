import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/AdminScreen/admin_T_n_C.dart';
import 'package:kbn_test/veiw/screen/AdminScreen/adminLogin.dart';
import 'package:kbn_test/veiw/widgets/boldText.dart';
import 'package:kbn_test/veiw/widgets/home_appbar_box.dart';
import 'package:kbn_test/veiw/screen/userScreen/home.dart';
import 'package:kbn_test/veiw/widgets/normalText.dart';

import '../../widgets/boxBTN.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<dynamic> companyList = [];
  List<dynamic> approvedCompanies = [];

  @override
  void initState() {
    // TODO: implement initState
    _fetchUserData();
    _fetchCompaniesData();
    super.initState();
  }

  Future<void> _fetchUserData() async {
    var userDetailsResponse = await ApiServices.fetchUserDetails();
    userDetails = userDetailsResponse;
  }

  Future<void> _fetchCompaniesData() async {
    var newApprovedCompanieData = await ApiServices.fetchAprovedCompanies();
    var newCompaniesData = await ApiServices.fetchPendingCompanie();

    print('CompanyList$newCompaniesData');
    print('ApprovedList$newApprovedCompanieData');

    setState(() {
      companyList = newCompaniesData['data'];
      approvedCompanies = newApprovedCompanieData['data'];
    });
  }

  // Method to add selected applicant
  void addSelectedApplicant(dynamic applicant) {
    setState(() {
      if (!approvedCompanies.contains(applicant)) {
        approvedCompanies.add(applicant);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              kbnLogo, // Kbn LoGO
              height: 40,
            ),
            // appbarWidget
            HomeAppBarBox(context,
                home: const AdminHomePage(),
                profileImage:
                    "${ApiServices.baseUrl}/${userDetails['user']['profile_image']}",
                T_and_C: const AdminTnC(),
                logOutTo: const AdminLogIn()),

            Container(
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
                              'Company name',
                              'KBN code',
                              'Website Link',
                              'LTD.',
                              'Status'
                            ],
                            // rows:approvedCompanies.map((approved){
                            //   return CustomTableRow(cells: cells)
                            // }).toList()

                            rows: [
                              CustomTableRow(
                                cells: [
                                  '19-08-2024',
                                  'ODAU APPS',
                                  '0369',
                                  'link',
                                  'PVT.ltd',
                                  const CustomStatusColumn(),
                                ],
                              ),
                              CustomTableRow(
                                cells: [
                                  '19-08-2024',
                                  'ODAU APPS',
                                  '0369',
                                  'link',
                                  'PVT.ltd',
                                  const CustomStatusColumn(),
                                ],
                              ),
                              CustomTableRow(
                                cells: [
                                  '19-08-2024',
                                  'ODAU APPS',
                                  '0369',
                                  'link',
                                  'PVT.ltd',
                                  const CustomStatusColumn(),
                                ],
                              ),
                              CustomTableRow(
                                cells: [
                                  '19-08-2024',
                                  'ODAU APPS',
                                  '0369',
                                  'link',
                                  'PVT.ltd',
                                  const CustomStatusColumn(),
                                ],
                              ),
                              // Add more rows here
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Right Section - Selected Applicants
                        Expanded(
                          flex: 1,
                          child: CustomTable(
                            headers: const ['Name', 'Websitelink', 'Contact'],
                            rows: companyList.map((company) {
                              return CustomTableRow(cells: [
                                company['name'],
                                company['company_website'],
                                CustomContactColumn(
                                  companyId: company['userId'],
                                ),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
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

class CustomStatusColumn extends StatefulWidget {
  const CustomStatusColumn({super.key});

  @override
  _CustomStatusColumnState createState() => _CustomStatusColumnState();
}

class _CustomStatusColumnState extends State<CustomStatusColumn> {
  String status = '';

  void _setStatus(String newStatus) {
    setState(() {
      status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (status != 'REJECTED')
          _buildStatusText(
            'SELECT', // shortText
            'SELECTED', // long TExt
            const Color(0xFF138395), // Color when selected
            'Select status',
            initialColor: const Color(0xFF138395), // Initial color for SELECT
          ),
        const SizedBox(height: 10),
        if (status != 'SELECTED')
          _buildStatusText(
            'REJECT',
            'REJECTED',
            const Color(0xFFEB1D1D), // Color when selected
            'Reject status',
            initialColor: Colors.red, // Initial color for REJECT
          ),
      ],
    );
  }

  Widget _buildStatusText(
    String shortText,
    String longText,
    Color color,
    String semanticLabel, {
    required Color initialColor,
  }) {
    return GestureDetector(
      onTap: () => _setStatus(longText),
      child: Container(
        width: 80,
        height: 15,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Border color
            width: status == longText ? 0.01 : 0.5, // Border width
          ),
          borderRadius: BorderRadius.circular(1.0), // Optional: Rounded corners
        ),
        child: Text(
          status == longText ? longText : shortText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: status == longText ? color : initialColor,
            fontSize: 10,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          semanticsLabel: semanticLabel,
        ),
      ),
    );
  }
}

class CustomContactColumn extends StatefulWidget {
  final int companyId;
  const CustomContactColumn({super.key, required this.companyId});

  @override
  State<CustomContactColumn> createState() => _CustomContactColumnState();
}

class _CustomContactColumnState extends State<CustomContactColumn> {
  Map<String, dynamic>? companyDetails; // Stores fetched details
  bool isLoading = true; // To manage loading state

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> fetchCompanyDetails(int companyId) async {
    try {
      var details = await ApiServices.fetchCompanyDetails(companyId);

      print('CompanyDetails$details');
      setState(() {
        companyDetails = details['data'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error appropriately
      print('Failed to load Company details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // used the container as a box widget
    return box(
      height: 15,
      width: 69,
      child: GestureDetector(
        onTap: () async {
          await fetchCompanyDetails(widget.companyId);
          if (companyDetails != null) {
            showProfileDialog(context); // Adding onTap function
          }
        },
        //  showProfileDialog(context), // Adding onTap function
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
              child: isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
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
                                color: Colors
                                    .grey[300], // Background color if no image
                                borderRadius:
                                    BorderRadius.circular(8), // Square corners
                                image: DecorationImage(
                                  image: companyDetails?['profile_image'] !=
                                          null
                                      ? NetworkImage(
                                          "${ApiServices.baseUrl}/${companyDetails?['profile_image']}")
                                      : const AssetImage(compnyLogo)
                                          as ImageProvider, // Use a placeholder if image is null
                                  fit: BoxFit
                                      .cover, // Adjusts image to cover the container
                                ),
                              ),
                            ),
                            const SizedBox(
                                width: 20), // Space between image and text

                            // Summary and Skills
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  boldText(
                                      text: companyDetails?['about_company'],
                                      size: 16),
                                  // Summary description
                                  normalText(text: profileSum),
                                  const SizedBox(height: 10),
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
                                boldText(
                                    text: companyDetails?['name'], size: 15),
                                const SizedBox(height: 5),
                                boldText(
                                    text: companyDetails?['company_website'],
                                    size: 15),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            const Spacer(),
                            box(
                              width: 105,
                              height: 25,
                              child: GestureDetector(
                                onTap: () => (), // Adding onTap function
                                child: const Center(
                                  child: Text(
                                    'APPROVE',
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
