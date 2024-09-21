// import 'package:flutter/material.dart';
// import 'package:kbn_test/service/apiServices.dart';
// import 'package:kbn_test/utilities/assets_path.dart';
// import 'package:kbn_test/utilities/colors.dart';
// import 'package:kbn_test/utilities/const.dart';
// import 'package:kbn_test/utilities/text_style.dart';
// import 'package:kbn_test/veiw/screen/userScreen/jobCards.dart';
// import 'package:kbn_test/veiw/screen/userScreen/jobDetails.dart';
// import 'package:kbn_test/veiw/screen/userScreen/userT_n_C.dart';
// import 'package:kbn_test/veiw/screen/userScreen/userWidgets/home_filter_box.dart';
// import 'package:kbn_test/veiw/screen/userScreen/userWidgets/upload_resume.dart';
// import 'package:kbn_test/veiw/widgets_common/home_appbar_box.dart';

// class UserHome extends StatefulWidget {
//   const UserHome({Key? key}) : super(key: key);

//   @override
//   _UserHomeState createState() => _UserHomeState();
// }

// class _UserHomeState extends State<UserHome> {
//   List<dynamic> _jobs = [];
//   int _currentPage = 1;
//   int? _totalPages = 1;
//   bool _shouldShowUploadResume = false;
//   bool _isLoading = true;

//   // State for selected filters
//   List<String> _selectedJobTypes = [];
//   List<String> _selectedExperience = [];
//   List<String> _selectedWorkModes = [];
//   List<String> _selectedLocations = [];
//   double _selectedSalaryStart = 0;
//   double _selectedSalaryEnd = 300000; // Default upper limit for salary

//   // State for filter items from API
//   Map<String, List<String>> dropDownItems = {
//     'jobTypes': [],
//     'experiences': [],
//     'locations': [],
//     'workModes': [],
//   };

//   @override
//   void initState() {
//     super.initState();
//     _checkResumeLink();
//     _fetchFilteredJobs(); // Initial fetch
//   }

//   Future<void> _checkResumeLink() async {
//     try {
//       var userDetails = await ApiServices.fetchUserDetails();
//       var resumeLink = userDetails['user']['resumeLink'];

//       setState(() {
//         _shouldShowUploadResume = resumeLink == null || resumeLink.isEmpty;
//       });
//     } catch (e) {
//       print('Error fetching user details: $e');
//     }
//   }

//   Future<void> _fetchFilteredJobs() async {
//     try {
//       setState(() {
//         _isLoading = true; // Show loading spinner
//       });

//       // Fetch filtered jobs based on the selected filters
//       final jobsResponse = await ApiServices.fetchFilteredJobs(
//         selectedJobType: _selectedJobTypes.isNotEmpty
//             ? _selectedJobTypes.join(",")
//             : "Job Type",
//         selectedSalary:
//             '${_selectedSalaryStart.toInt()}-${_selectedSalaryEnd.toInt()}', // Salary filter
//         selectedExperience: _selectedExperience.isNotEmpty
//             ? _selectedExperience.join(",")
//             : "Experience",
//         selectedWorkMode: _selectedWorkModes.isNotEmpty
//             ? _selectedWorkModes.join(",")
//             : "Work Mode",
//         selectedLocation: _selectedLocations.isNotEmpty
//             ? _selectedLocations.join(",")
//             : "Location",
//         pageNumber: _currentPage, // Pass the current page
//       );

//       // Extract jobs and total jobs from the response
//       final jobs = jobsResponse['data'] as List<dynamic>;
//       final totalJobsPosted = jobsResponse['totalJobs'] as int;

//       setState(() {
//         _jobs = jobs;
//         // Calculate total pages based on the total number of jobs
//         _totalPages = totalJobsPosted == 0 ? 1 : (totalJobsPosted / 8).ceil();
//         _isLoading = false; // Hide loading spinner
//       });
//     } catch (e) {
//       print("Error fetching filtered jobs: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _goToPreviousPage() {
//     if (_currentPage > 1) {
//       setState(() {
//         _currentPage--;
//       });
//       _fetchFilteredJobs(); // Fetch jobs for the previous page
//     }
//   }

//   void _goToNextPage() {
//     if (_currentPage < _totalPages!) {
//       setState(() {
//         _currentPage++;
//       });
//       _fetchFilteredJobs(); // Fetch jobs for the next page
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Stack(
//               children: [
//                 SingleChildScrollView(
//                   child: SizedBox(
//                     height: size.height,
//                     width: size.width,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Center(child: Image(image: AssetImage(kbnLogo))),
//                         HomeAppBarBox(
//                           context,
//                           T_and_C: const user_T_n_C(),
//                           termscolor: white,
//                           profileImage:
//                               "${ApiServices.baseUrl}/${userDetails['user']['profile_image']}",
//                         ),
//                         const SizedBox(height: 10),
//                         HomeFilterBox(
//                           onFilterApplied: (filteredJobs) {
//                             setState(() {
//                               _jobs = filteredJobs;
//                             });
//                           },
//                         ),
//                         const SizedBox(height: 10),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 50),
//                           child: Text(
//                             latestjob,
//                             style: AppTextStyle.tactexthead,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 40),
//                             child: GridView.builder(
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: _getCrossAxisCount(size),
//                                 crossAxisSpacing: 30,
//                                 mainAxisSpacing: 10,
//                                 childAspectRatio: _getChildAspectRatio(size),
//                               ),
//                               itemCount: _jobs.length,
//                               itemBuilder: (context, index) {
//                                 final job = _jobs[index];
//                                 return GestureDetector(
//                                   onTap: () async {
//                                     try {
//                                       await ApiServices.postJobDetails(
//                                           job['jobId']);
//                                       Navigator.push(context, MaterialPageRoute(
//                                         builder: (context) {
//                                           return JobDetails(
//                                             jobId: job['jobId'],
//                                             companyId: job['companyId'],
//                                             firmname:
//                                                 job['company_name'].toString(),
//                                             jobTitle: job['title'].toString(),
//                                             jobSummary:
//                                                 job['job_summary'].toString(),
//                                             expLevel: job['experience_level']
//                                                 .toString(),
//                                             jobMode: job['job_mode'].toString(),
//                                             jobType: job['job_type'].toString(),
//                                             keyResponsibilities:
//                                                 job['key_responsibilities']
//                                                     as List<dynamic>,
//                                             jobReq: job['job_requirements']
//                                                 as Map<String, dynamic>,
//                                             salary: job['salary'],
//                                             currentVacancy: job['vacancy'],
//                                             workLocation:
//                                                 job['location'].toString(),
//                                             companywebsite:
//                                                 job['company_website']
//                                                     .toString(),
//                                             datePosted:
//                                                 job['created_at'].toString(),
//                                             companyImage:
//                                                 job['company_profile_image'],
//                                             status: job['application_status']
//                                                 .toString(),
//                                           );
//                                         },
//                                       ));
//                                     } catch (error) {
//                                       print('Error in onTap: $error');
//                                     }
//                                     // Navigate to JobDetails
//                                   },
//                                   child: LatestJobCard(
//                                     firmname: job['company_name'].toString(),
//                                     jobTitle: job['title'].toString(),
//                                     jobSummary: job['job_summary'].toString(),
//                                     expLevel:
//                                         job['experience_level'].toString(),
//                                     jobMode: job['job_mode'].toString(),
//                                     jobType: job['job_type'].toString(),
//                                     companyImage:
//                                         job['company_profile_image'].toString(),
//                                     datePosted: job['created_at'].toString(),
//                                     status:
//                                         job['application_status'].toString(),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                         // Pagination Controls
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             PaginatedButton(
//                               onPressed: _goToPreviousPage,
//                               child: const Text('Previous'),
//                             ),
//                             const SizedBox(width: 20),
//                             Text('Page $_currentPage of $_totalPages'),
//                             const SizedBox(width: 20),
//                             PaginatedButton(
//                               onPressed: _goToNextPage,
//                               child: const Text('Next'),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 if (_shouldShowUploadResume)
//                   UploadMyResume(
//                     onResumeUploaded: () async {
//                       await _checkResumeLink();
//                     },
//                   ),
//               ],
//             ),
//     );
//   }

//   int _getCrossAxisCount(Size size) {
//     if (size.width < 900) return 1;
//     if (size.width < 1200) return 2;
//     if (size.width < 1600) return 3;
//     return 4;
//   }

//   double _getChildAspectRatio(Size size) {
//     if (size.width < 900) return size.width * 0.1 / size.width * 15;
//     if (size.width < 1200) return size.width * 0.15 / size.width * 10;
//     if (size.width < 1600) return size.width * 0.22 / size.width * 6;
//     return size.width * 0.25 / size.width * 5;
//   }
// }

// // Create a PaginatedButton widget
// class PaginatedButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final Widget child;

//   const PaginatedButton({
//     super.key,
//     required this.onPressed,
//     required this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       child: child,
//     );
//   }
// }
