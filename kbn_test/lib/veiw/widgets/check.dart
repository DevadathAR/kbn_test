// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class UserHome extends StatefulWidget {
//   const UserHome({super.key});

//   @override
//   _UserHomeState createState() => _UserHomeState();
// }

// class _UserHomeState extends State<UserHome> {
//   List<dynamic> _jobs = [];
//   bool _isDialogShown = false; // To ensure the dialog is shown only once

//   @override
//   void initState() {
//     super.initState();
//     _fetchJobTitles();
//     // Schedule the dialog to show after the build is complete
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _checkAndShowWelcomeDialog();
//     });
//   }

//   Future<void> _fetchJobTitles() async {
//     var jobs = await ApiServices.fetchJobTitles();
//     setState(() {
//       _jobs = jobs;
//     });
//   }

//   Future<void> _checkAndShowWelcomeDialog() async {
//     // Replace with actual userId and token
//     int userId = 2; // Example userId
//     String token = 'your_auth_token'; // Example token

//     try {
//       var userDetails = await ApiServices.fetchUserDetails(userId, token);
//       var resumeLink = userDetails['user']['resumeLink'];

//       if (resumeLink == null && !_isDialogShown) {
//         _showWelcomeDialog();
//         setState(() {
//           _isDialogShown = true; // Ensure the dialog is shown only once
//         });
//       }
//     } catch (e) {
//       print('Error checking user details: $e');
//     }
//   }

//   void _showWelcomeDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return UploadMyResume();
//       },
//     );
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
//                                 try {
//                                   await ApiServices.postJobDetails(
//                                       job['jobId'], job['companyId']);
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
//                                   print("Error in onTap: $error");
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
//         ],
//       ),
//     );
//   }
// }
