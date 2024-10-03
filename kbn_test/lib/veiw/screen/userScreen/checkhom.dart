// import 'package:flutter/material.dart';
// import 'package:kbn_test/service/apiServices.dart';
// import 'package:kbn_test/utilities/assets_path.dart';
// import 'package:kbn_test/utilities/colors.dart';
// import 'package:kbn_test/utilities/const.dart';
// import 'package:kbn_test/utilities/text_style.dart';

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
//   List<String> _selectedJobTypes = ["Job Type"];
//   List<String> _selectedExperience = ["Experience"];
//   List<String> _selectedWorkModes = ["Work Mode"];
//   List<String> _selectedLocations = ["Location"];
//   double _selectedSalaryStart = 0;
//   double _selectedSalaryEnd = 300000; // Default upper limit for salary

//   // State for filter items from API
//   Map<String, List<String>> dropDownItems = {
//     'jobTypes': ["Job Type"],
//     'experiences': ["Experience"],
//     'locations': ["Location"],
//     'workModes': ["Work Mode"],
//   };

//   @override
//   void initState() {
//     super.initState();
//     _fetchDropDownItems();
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

//   Future<void> _fetchDropDownItems() async {
//     try {
//       var items = await ApiServices.fetchDropdownBoxItems();
//       setState(() {
//         dropDownItems = {
//           'jobTypes': ["Job Type"] + items['jobTypes']!,
//           'experiences': ["Experience"] + items['experiences']!,
//           'locations': ["Location"] + items['locations']!,
//           'workModes': ["Work Mode"] + items['workModes']!,
//         };
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Error fetching dropdown items: $e');
//       setState(() {
//         _isLoading = false;
//       });
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
//                         const SizedBox(height: 10),
//                         // Integrated HomeFilterBox
//                         buildFilterBox(size),
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
//                         )
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
//       drawer: Padding(
//         padding: EdgeInsets.only(top: size.width > 600 ? 230.0 : 210),
//         child: Drawer(
//           child: Container(
//             height: size.height * 0.5,
//             width: size.width * 0.25,
//             color: tealblue,
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 _buildFilterSection('Job Type', dropDownItems['jobTypes'] ?? [],
//                     _selectedJobTypes),
//                 _buildFilterSection('Experience',
//                     dropDownItems['experiences'] ?? [], _selectedExperience),
//                 _buildFilterSection('Location',
//                     dropDownItems['locations'] ?? [], _selectedLocations),
//                 _buildFilterSection('Work Mode',
//                     dropDownItems['workModes'] ?? [], _selectedWorkModes),
//                 _buildSalarySlider(),
//                 const SizedBox(height: 20),
//                 _buildApplyButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildFilterBox(Size size) {
//     return Container(
//       height: 100,
//       width: size.width,
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(2)),
//         color: tealblue,
//       ),
//       child: (size.width >= 900)
//           ? Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 buildDropdown(dropDownItems['jobTypes']!, "Job Type",
//                     (newValue) {
//                   setState(() {
//                     _selectedJobTypes = [newValue!];
//                     _fetchFilteredJobs();
//                   });
//                 }),
//                 const VerticalDivider(),
//                 buildDropdown(
//                     ['Salary Range', '0-25000', '25000-50000', '50000-75000'],
//                     "Salary", (newValue) {
//                   setState(() {
//                     final split = newValue!.split("-");
//                     _selectedSalaryStart = double.parse(split[0]);
//                     _selectedSalaryEnd = double.parse(split[1]);
//                     _fetchFilteredJobs();
//                   });
//                 }),
//                 const VerticalDivider(),
//                 buildDropdown(dropDownItems['experiences']!, "Experience",
//                     (newValue) {
//                   setState(() {
//                     _selectedExperience = [newValue!];
//                     _fetchFilteredJobs();
//                   });
//                 }),
//                 const VerticalDivider(),
//                 buildDropdown(dropDownItems['workModes']!, "Work Mode",
//                     (newValue) {
//                   setState(() {
//                     _selectedWorkModes = [newValue!];
//                     _fetchFilteredJobs();
//                   });
//                 }),
//                 const VerticalDivider(),
//                 buildDropdown(dropDownItems['locations']!, "Location",
//                     (newValue) {
//                   setState(() {
//                     _selectedLocations = [newValue!];
//                     _fetchFilteredJobs();
//                   });
//                 }),
//               ],
//             )
//           : GestureDetector(
//               onTap: () {
//                 Scaffold.of(context).openDrawer();
//               },
//               child: const Padding(
//                 padding: EdgeInsets.only(left: 25),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Image(image: AssetImage(filterPng)),
//                     Padding(
//                       padding: EdgeInsets.only(left: 15),
//                       child: Text(
//                         filters,
//                         style: AppTextStyle.flitertxt,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   Widget buildDropdown(List<String> items, String selectedItem,
//       ValueChanged<String?> onChanged) {
//     return DropdownButton<String>(
//       dropdownColor: tealblue,
//       value: selectedItem,
//       iconEnabledColor: homecolor,
//       underline: const SizedBox.shrink(),
//       items: items.map((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value, style: AppTextStyle.flitertxt),
//         );
//       }).toList(),
//       onChanged: onChanged,
//     );
//   }

//   int _getCrossAxisCount(Size size) {
//     return size.width >= 1200 ? 4 : 2;
//   }

//   double _getChildAspectRatio(Size size) {
//     return size.width >= 1200 ? 1.5 : 0.7;
//   }

//   Widget _buildFilterSection(String title, List<String> items, List<String> selectedItems) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: DropdownButtonFormField<String>(
//         value: selectedItems.isNotEmpty ? selectedItems.first : items[0],
//         onChanged: (newValue) {
//           setState(() {
//             selectedItems.clear();
//             selectedItems.add(newValue!);
//           });
//         },
//         items: items.map((String item) {
//           return DropdownMenuItem<String>(
//             value: item,
//             child: Text(item),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildSalarySlider() {
//     return Column(
//       children: [
//         Text('Salary Range: ${_selectedSalaryStart.toInt()} - ${_selectedSalaryEnd.toInt()}'),
//         RangeSlider(
//           values: RangeValues(_selectedSalaryStart, _selectedSalaryEnd),
//           min: 0,
//           max: 300000,
//           divisions: 6,
//           labels: RangeLabels(
//             _selectedSalaryStart.toInt().toString(),
//             _selectedSalaryEnd.toInt().toString(),
//           ),
//           onChanged: (RangeValues values) {
//             setState(() {
//               _selectedSalaryStart = values.start;
//               _selectedSalaryEnd = values.end;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildApplyButton() {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: ElevatedButton(
//         onPressed: () {
//           Navigator.pop(context); // Close the drawer
//           _fetchFilteredJobs(); // Apply filters and fetch jobs
//         },
//         child: const Text("Apply"),
//       ),
//     );
//   }
// }

// class PaginatedButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final Widget child;

//   const PaginatedButton({Key? key, required this.onPressed, required this.child})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(onPressed: onPressed, child: child);
//   }
// }

// class UploadMyResume extends StatelessWidget {
//   final VoidCallback onResumeUploaded;

//   const UploadMyResume({Key? key, required this.onResumeUploaded})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: onResumeUploaded,
//         child: const Text('Upload Resume'),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';

// class JobDetails extends StatelessWidget {
//   final String jobId;
//   final String companyId;
//   final String firmname;
//   final String jobTitle;
//   final String jobSummary;
//   final String expLevel;
//   final String jobMode;
//   final String jobType;
//   final List<dynamic> keyResponsibilities;
//   final Map<String, dynamic> jobReq;
//   final String salary;
//   final int currentVacancy;
//   final String workLocation;
//   final String companywebsite;
//   final String datePosted;
//   final String companyImage;
//   final String status;

//   const JobDetails({
//     Key? key,  // Named key parameter for the widget
//     required this.jobId,
//     required this.companyId,
//     required this.firmname,
//     required this.jobTitle,
//     required this.jobSummary,
//     required this.expLevel,
//     required this.jobMode,
//     required this.jobType,
//     required this.keyResponsibilities,
//     required this.jobReq,
//     required this.salary,
//     required this.currentVacancy,
//     required this.workLocation,
//     required this.companywebsite,
//     required this.datePosted,
//     required this.companyImage,
//     required this.status,
//   }) : super(key: key);  // Pass the key to the parent StatelessWidget

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(jobTitle),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Company: $firmname',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text('Job Title: $jobTitle'),
//             Text('Experience Level: $expLevel'),
//             Text('Job Mode: $jobMode'),
//             Text('Job Type: $jobType'),
//             Text('Salary: $salary'),
//             Text('Location: $workLocation'),
//             Text('Vacancy: $currentVacancy'),
//             const SizedBox(height: 10),
//             const Text('Key Responsibilities:'),
//             for (var responsibility in keyResponsibilities)
//               Text('- $responsibility'),
//             const SizedBox(height: 10),
//             const Text('Job Requirements:'),
//             for (var requirement in jobReq.entries)
//               Text('${requirement.key}: ${requirement.value}'),
//             const SizedBox(height: 10),
//             Text('Posted on: $datePosted'),
//             const SizedBox(height: 10),
//             Text('Status: $status'),
//             const SizedBox(height: 20),
//             Image.network(companyImage, height: 100, width: 100),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Action for applying to the job
//               },
//               child: const Text('Apply Now'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class LatestJobCard extends StatelessWidget {
//   final String firmname;
//   final String jobTitle;
//   final String jobSummary;
//   final String expLevel;
//   final String jobMode;
//   final String jobType;
//   final String companyImage;
//   final String datePosted;
//   final String status;

//   const LatestJobCard({
//     Key? key,
//     required this.firmname,
//     required this.jobTitle,
//     required this.jobSummary,
//     required this.expLevel,
//     required this.jobMode,
//     required this.jobType,
//     required this.companyImage,
//     required this.datePosted,
//     required this.status,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: [
//           Image.network(companyImage),
//           Text(firmname),
//           Text(jobTitle),
//           Text(jobSummary),
//           Text(expLevel),
//           Text(jobMode),
//           Text(jobType),
//           Text(datePosted),
//           Text(status),
//         ],
//       ),
//     );
//   }
// }

