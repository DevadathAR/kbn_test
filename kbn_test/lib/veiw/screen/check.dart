// import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// import 'package:kbn_test/service/api_service.dart';
// import 'package:kbn_test/utilities/assets_path.dart';
// import 'package:kbn_test/utilities/colors.dart';
// import 'package:kbn_test/utilities/const.dart';
// import 'package:kbn_test/utilities/text_style.dart';
// import 'package:kbn_test/veiw/auth/user_auth/UserLoginPage.dart';
// import 'package:kbn_test/veiw/screen/user_screen/JobDetails.dart';
// import 'package:kbn_test/veiw/screen/user_screen/termsandcond_applicant.dart';

// import 'package:kbn_test/veiw/widgets/home_appbar_box.dart';
// import 'package:kbn_test/veiw/widgets/home_filter_box.dart';

// class UserHome extends StatefulWidget {
//   const UserHome({super.key});

//   @override
//   _UserHomeState createState() => _UserHomeState();
// }

// class _UserHomeState extends State<UserHome> {
//   List<dynamic> _jobs = [];
//   int _currentPage = 1;
//   int _totalPages = 10;

//   @override
//   void initState() {
//     super.initState();
//     _fetchJobTitles();
//   }

//   Future<void> _fetchJobTitles() async {
//     var jobs = await ApiServices
//         .fetchJobTitles(); // Call fetchJobTitles from ApiServices
//     setState(() {
//       _jobs = jobs;
//       _totalPages = (jobs.length / 8).ceil(); // Calculate total pages
//     });
//   }

//   Future<void> _fetchFilteredJobs(int pageNumber) async {
//     var filteredJobs = await ApiServices.fetchFilteredJobs(
//       pageNumber: pageNumber,
//       pageSize: 8,
//     );
//     setState(() {
//       _jobs = filteredJobs;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: SizedBox(
//               height: size.height * 1,
//               width: size.width * 1,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Center(child: Image(image: AssetImage(kbnLogo))),
//                   HomeAppBarBox(context,
//                       profileImage:
//                           "${ApiServices.baseUrl}/${userDetails['user']['profile_image']}",
//                       T_and_C: const TaC(),
//                       logOutTo: const UserLoginPage(),
//                       termscolor: white),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   HomeFilterBox(
//                     onFilterApplied: (filteredJobs) {
//                       setState(() {
//                         _jobs = filteredJobs;
//                       });
//                     },
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 50),
//                     child: Text(
//                       latestjob,
//                       style: AppTextStyle.tactexthead,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 40),
//                       child: SizedBox(
//                         child: GridView.builder(
//                           physics: const NeverScrollableScrollPhysics(),
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 4,
//                                   crossAxisSpacing: 30,
//                                   mainAxisSpacing: 10,
//                                   childAspectRatio: 261 / 190),
//                           itemCount: _jobs.length,
//                           itemBuilder: (context, index) {
//                             final job = _jobs[index];
//                             return GestureDetector(
//                               onTap: () async {
//                                 // print(job['companyId']);
//                                 try {
//                                   await ApiServices.postJobDetails(
//                                       job['jobId'], job['companyId']);

//                                   // Navigate to JobDetails after successfully posting job details
//                                   Navigator.push(context, MaterialPageRoute(
//                                     builder: (context) {
//                                       return JobDetails(
//                                         jobId: job['jobId'], // Pass jobId
//                                         companyId:
//                                             job['companyId'], // Pass companyId
//                                         firmname:
//                                             job['company_name'].toString(),
//                                         jobTitle: job['title'].toString(),
//                                         jobSummary:
//                                             job['job_summary'].toString(),
//                                         expLevel:
//                                             job['experience_level'].toString(),
//                                         jobMode: job['job_mode'].toString(),
//                                         jobType: job['job_type'].toString(),
//                                         keyResponsibilities:
//                                             job['key_responsibilities']
//                                                 as List<dynamic>,
//                                         jobReq: job['job_requirements']
//                                             as Map<String, dynamic>,
//                                         salary: job['salary'],
//                                         currentVacancy: job['vacancy'],
//                                         workLocation:
//                                             job['location'].toString(),
//                                         companywebsite:
//                                             job['company_website'].toString(),
//                                         datePosted:
//                                             job['created_at'].toString(),
//                                         companyImage:
//                                             job['company_profile_image']
//                                                 .toString(),
//                                       );
//                                     },
//                                   ));
//                                 } catch (error) {
//                                   print(
//                                       "Error in onTap: $error"); // Handle navigation errors
//                                 }
//                               },
//                               child: LatestJobCard(
//                                 firmname: job['company_name'].toString(),
//                                 jobTitle: job['title'].toString(),
//                                 jobSummary: job['job_summary'].toString(),
//                                 expLevel: job['experience_level'].toString(),
//                                 jobMode: job['job_mode'].toString(),
//                                 jobType: job['job_type'].toString(),
//                                 datePosted: job['created_at'].toString(),
//                                 companyImage:
//                                     job['company_profile_image'].toString(),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
// //           Align(
// //   alignment: Alignment.bottomCenter,
// //   child: Container(
// //     color: Colors.black,
// //     height: 50,
// //     width: 200,
// //     child: Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         // Display previous page button if we're not on the first page
// //         if (_currentPage > 1) // Ensure it doesn't show when on the first page
// //           TextButton(
// //             onPressed: () {
// //               setState(() {
// //                 _currentPage--;  // Go to previous page
// //               });
// //               _fetchFilteredJobs(_currentPage);
// //             },
// //             child: const Text("<<"),
// //           ),

// //         // Display next page button if there are more pages
// //         if (_currentPage < _totalPages)
// //           TextButton(
// //             onPressed: () {
// //               setState(() {
// //                 _currentPage++;  // Go to next page
// //               });
// //               _fetchFilteredJobs(_currentPage);
// //             },
// //             child: const Text(">>"),
// //           ),
// //       ],
// //     ),
// //   ),
// // )
//         ],
//       ),
//     );
//   }
// }