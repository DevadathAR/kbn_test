// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:kbn_test/service/apiServices.dart';
// import 'package:kbn_test/utilities/assets_path.dart';
// import 'package:kbn_test/utilities/colors.dart';
// import 'package:kbn_test/veiw/screen/AdminScreen/admin_T_n_C.dart';
// import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/warningDialogue.dart';
// import 'package:kbn_test/veiw/widgets_common/boldText.dart';
// import 'package:kbn_test/veiw/widgets_common/home_appbar_box.dart';
// import 'package:kbn_test/veiw/widgets_common/normalText.dart';
// import 'package:kbn_test/veiw/widgets_common/statusUpdate.dart';
// import 'package:kbn_test/veiw/widgets_common/warningDialogue.dart';

// import '../../widgets_common/boxBTN.dart';

// class AdminHomePage extends StatefulWidget {
//   const AdminHomePage({super.key});

//   @override
//   State<AdminHomePage> createState() => _AdminHomePageState();
// }

// class _AdminHomePageState extends State<AdminHomePage> {
//   List<dynamic> companyList = [];
//   List<dynamic> approvedCompanies = [];
//   // List<dynamic> selectedCompanies = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     _fetchUserData();
//     _fetchCompaniesData();
//     super.initState();
//   }

//   Future<void> _fetchUserData() async {
//     var userDetailsResponse = await ApiServices.fetchUserDetails();
//     userDetails = userDetailsResponse;
//   }

//   Future<void> _fetchCompaniesData() async {
//     var newApprovedCompanieData = await ApiServices.fetchAprovedCompanies();
//     var newCompaniesData = await ApiServices.fetchPendingCompanie();

//     print('CompanyList$newCompaniesData');
//     print('ApprovedList$newApprovedCompanieData');

//     setState(() {
//       companyList = newCompaniesData['data'];
//       approvedCompanies = newApprovedCompanieData['data'];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Image.asset(
//               kbnLogo, // Kbn LoGO
//               height: 40,
//             ),
//             // appbarWidget
//             HomeAppBarBox(
//               context,
//               home: const AdminHomePage(),
//               profileImage: "${ApiServices.baseUrl}/${userDetails['user']['profile_image']}",
//               T_and_C: const AdminTnC(),
//               // logOutTo: const AdminLogIn(),
//             ),

//             Container(
//               padding: const EdgeInsets.all(16.0),
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   if (constraints.maxWidth > 800) {
//                     // Wide screen layout
//                     return Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Left Section - Applicant Details
//                         Expanded(
//                           flex: 2,
//                           child: CustomTable(
//                               headers: const [
//                                 'Date',
//                                 'Company name',
//                                 'KBN code',
//                                 'Website Link',
//                                 'LTD.',
//                                 'Status'
//                               ],
//                               rows: approvedCompanies.map((approved) {
//                                 // Format the date
//                                 String formattedDate =
//                                     approved['last_admin_status'] != null
//                                         ? DateFormat('yyyy-MM-dd').format(
//                                             DateTime.parse(
//                                                 approved['last_admin_status']))
//                                         : "N/A";

//                                 return CustomTableRow(cells: [
//                                   formattedDate,
//                                   approved['name'] ?? "N?A",
//                                   approved['kbn_code'] ?? "N/A",
//                                   approved['company_website'] ?? "N/A",
//                                   approved['business_type'] ?? "N/A",
//                                   CustomStatusColumn(
//                                     status: approved['admin_status'],
//                                     companyId: approved['userId'],
//                                     onSelect: () {},
//                                     onStatusChange: () {
//                                       _fetchCompaniesData();
//                                     },
//                                   )
//                                 ]);
//                               }).toList()),
//                         ),
//                         const SizedBox(width: 16),
//                         // Right Section - Selected Applicants
//                         Expanded(
//                           flex: 1,
//                           child: CustomTable(
//                             headers: const ['Name', 'Websitelink', 'Contact'],
//                             rows: companyList.map((company) {
//                               return CustomTableRow(cells: [
//                                 company['name'],
//                                 company['company_website'],
//                                 CustomContactColumn(
//                                   companyId: company['userId'],
//                                   onApproval: _fetchCompaniesData,
//                                 ),
//                               ]);
//                             }).toList(),
//                           ),
//                         ),
//                       ],
//                     );
//                   } else {
//                     return const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [],
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Custom Table Widget
// class CustomTable extends StatelessWidget {
//   final List<String> headers;
//   final List<CustomTableRow> rows;

//   const CustomTable({super.key, required this.headers, required this.rows});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Table(
//         border: TableBorder.all(),
//         columnWidths: headers.asMap().map((index, _) {
//           return MapEntry(index, const FixedColumnWidth(100));
//         }),
//         children: [
//           // Header Row
//           TableRow(
//             children: headers
//                 .map((header) => CustomTableHeader(text: header))
//                 .toList(),
//           ),
//           // Data Rows
//           ...rows.map((row) => row.buildRow()),
//         ],
//       ),
//     );
//   }
// }

// // Custom Table Row Widget
// class CustomTableRow {
//   final List<dynamic> cells;

//   CustomTableRow({required this.cells});

//   TableRow buildRow() {
//     return TableRow(
//       children: cells
//           .map((cell) => SizedBox(
//                 width: 100,
//                 height: 70,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: cell is Widget ? cell : Text(cell.toString()),
//                 ),
//               ))
//           .toList(),
//     );
//   }
// }

// // Custom Table Header Widget
// class CustomTableHeader extends StatelessWidget {
//   final String text;

//   const CustomTableHeader({super.key, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         text,
//         style: const TextStyle(fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

// class CustomStatusColumn extends StatefulWidget {
//   final String status;
//   final VoidCallback onSelect; // Callback for when Select is pressed
//   final int companyId; // Add the applicationId as a parameter
//   final VoidCallback onStatusChange; // Callback to refresh data
//   const CustomStatusColumn({
//     super.key,
//     required this.status,
//     required this.onSelect,
//     required this.companyId,
//     required this.onStatusChange,
//   });

//   @override
//   _CustomStatusColumnState createState() => _CustomStatusColumnState();
// }

// class _CustomStatusColumnState extends State<CustomStatusColumn> {
//   String status = '';

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // status = widget.status;
//   }

//   void _setStatus(String newStatus) async {
//     setState(() {
//       status = newStatus;
//     });
//     // Proceed with the API call
//     try {
//       await ApiServices.updateAdminStatus(newStatus, widget.companyId);
//       // Display a success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Status updated to $newStatus successfully!')),
//       );
//       widget.onStatusChange();
//     } catch (e) {
//       print('Error updating status: $e');
//       // Handle the error case
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error updating status: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         StatusButton(
//           text: 'SELECT',
//           textColor: const Color(0xFF138395), // tealblue color
//           onTap: () => _setStatus('SELECTED'),
//         ),
//         const SizedBox(height: 10),
//         StatusButton(
//           text: 'REJECT',
//           textColor: Colors.red,
//           onTap: () => _setStatus('REJECTED'),
//         ),
//       ],
//     );
//   }
// }

// class CustomContactColumn extends StatefulWidget {
//   final VoidCallback onApproval;
//   final int companyId;
//   const CustomContactColumn(
//       {super.key, required this.companyId, required this.onApproval});

//   @override
//   State<CustomContactColumn> createState() => _CustomContactColumnState();
// }

// class _CustomContactColumnState extends State<CustomContactColumn> {
//   Map<String, dynamic>? companyDetails; // Stores fetched details
//   bool isLoading = true; // To manage loading state

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   Future<void> fetchCompanyDetails(int companyId) async {
//     try {
//       var details = await ApiServices.fetchCompanyDetails(companyId);

//       print('CompanyDetails$details');
//       setState(() {
//         companyDetails = details['data'];
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       // Handle error appropriately
//       print('Failed to load Company details: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // used the container as a box widget
//     return box(
//       height: 15,
//       width: 69,
//       child: GestureDetector(
//         onTap: () async {
//           await fetchCompanyDetails(widget.companyId);
//           if (companyDetails != null) {
//             showProfileDialog(
//                 context, widget.onApproval); // Adding onTap function
//           }
//         },
//         //  showProfileDialog(context), // Adding onTap function
//         child: Container(
//           child: const Center(
//             child: Text(
//               'VIEW DETAILS',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: tealblue,
//                 fontSize: 10,
//                 fontFamily: 'Poppins',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void showProfileDialog(BuildContext context, VoidCallback onApproval) {
//     showDialog(
//       context: context,
//       barrierColor: semitransp,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: SizedBox(
//             width: 516,
//             height: 373,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: isLoading == true
//                   ? const Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Image and summary row
//                         Row(
//                           children: [
//                             // Profile Image
//                             Container(
//                               width: 210,
//                               height: 210,
//                               decoration: BoxDecoration(
//                                 color: Colors
//                                     .grey[300], // Background color if no image
//                                 borderRadius:
//                                     BorderRadius.circular(8), // Square corners
//                                 image: DecorationImage(
//                                   image: companyDetails?['profile_image'] !=
//                                           null
//                                       ? NetworkImage(
//                                           "${ApiServices.baseUrl}/${companyDetails?['profile_image']}")
//                                       : const AssetImage(compnyLogo)
//                                           as ImageProvider, // Use a placeholder if image is null
//                                   fit: BoxFit
//                                       .cover, // Adjusts image to cover the container
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                                 width: 20), // Space between image and text

//                             // Summary and Skills
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(height: 10),
//                                   boldText(text: "About Company", size: 16),
//                                   // Summary description
//                                   normalText(
//                                     text: companyDetails?['about_company'] ??
//                                         "N/A",
//                                   ),
//                                   const SizedBox(height: 10),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         // applicant name and designation
//                         Row(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 boldText(
//                                     text: companyDetails?['name'] ?? "N/A",
//                                     size: 15),
//                                 const SizedBox(height: 5),
//                                 boldText(
//                                     text: companyDetails?['company_website'] ??
//                                         "N/A",
//                                     size: 15),
//                               ],
//                             ),
//                             const Spacer(),
//                           ],
//                         ),
//                         const SizedBox(height: 25),
//                         Row(
//                           children: [
//                             const Spacer(),
//                             box(
//                               width: 105,
//                               height: 25,
//                               child: GestureDetector(
//                                 onTap: () async {
//                                   await showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return WarningDialog(
//                                             title: "Confirm Approval",
//                                             content:
//                                                 'Are you sure you want to approve this company?',
//                                             onConfirm: () {
//                                               approveCompany(onApproval);
//                                             });
//                                         // Adding onTap function
//                                       });
//                                 },
//                                 child: const Center(
//                                   child: Text(
//                                     'APPROVE',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       color: tealblue,
//                                       fontSize: 10,
//                                       fontFamily: 'Poppins',
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   bool isApproving = false;

//   void approveCompany(VoidCallback onApproval) async {
//     setState(() {
//       isApproving = true; // Start loading
//     });
//     try {
//       await ApiServices.approveCompany(widget.companyId);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Company approved successfully!'),
//         ),
//       );
//       onApproval();
//       // Dismiss the dialog after success
//       Navigator.of(context).pop();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to approve company: $e'),
//         ),
//       );
//     } finally {
//       setState(() {
//         isApproving = false; // Stop loading
//       });
//     }
//   }


// }
