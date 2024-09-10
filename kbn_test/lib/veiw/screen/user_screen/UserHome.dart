import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kbn_test/service/api_service.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/user_auth/UserLoginPage.dart';
import 'package:kbn_test/veiw/screen/user_screen/JobDetails.dart';
import 'package:kbn_test/veiw/screen/user_screen/termsandcond_applicant.dart';

import 'package:kbn_test/veiw/widgets/home_appbar_box.dart';
import 'package:kbn_test/veiw/widgets/home_filter_box.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List<dynamic> _jobs = [];
  int _currentPage = 1;
  int ?_totalPages =1;

  @override
  void initState() {
    super.initState();
    _fetchJobTitles();
  }

  Future<void> _fetchJobTitles() async {
    var jobs = await ApiServices
        .fetchJobTitles(); // Call fetchJobTitles from ApiServices
    setState(() {
      _jobs = jobs;
      _totalPages = ((jobs.length / 8)+1).ceil(); // Calculate total pages
    });
  }

  Future<List<dynamic>> _fetchFilteredJobs(int pageNumber) async {
    var filteredJobs = await ApiServices.fetchFilteredJobs(
      pageNumber: pageNumber,
      pageSize: 8,
    );
    setState(() {
      _jobs = filteredJobs;
    });
    return filteredJobs;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: size.height * 1,
              width: size.width * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Image(image: AssetImage(kbnLogo))),
                  HomeAppBarBox(context,
                      profileImage:
                          "${baseUrl}/${userDetails['user']['profile_image']}",
                      T_and_C: const TaC(),
                      logOutTo: const UserLoginPage(),
                      termscolor: white),
                  const SizedBox(
                    height: 10,
                  ),
                  HomeFilterBox(
                    onFilterApplied: (filteredJobs) {
                      setState(() {
                        _jobs = filteredJobs;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Text(
                      latestjob,
                      style: AppTextStyle.tactexthead,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: SizedBox(
                        child: GridView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 261 / 190),
                          itemCount: _jobs.length,
                          itemBuilder: (context, index) {
                            final job = _jobs[index];
                            return GestureDetector(
                              onTap: () async {
                                // print(job['companyId']);
                                try {
                                  await ApiServices.postJobDetails(
                                      job['jobId'], job['companyId']);

                                  // Navigate to JobDetails after successfully posting job details
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return JobDetails(
                                        jobId: job['jobId'], // Pass jobId
                                        companyId:
                                            job['companyId'], // Pass companyId
                                        firmname:
                                            job['company_name'].toString(),
                                        jobTitle: job['title'].toString(),
                                        jobSummary:
                                            job['job_summary'].toString(),
                                        expLevel:
                                            job['experience_level'].toString(),
                                        jobMode: job['job_mode'].toString(),
                                        jobType: job['job_type'].toString(),
                                        keyResponsibilities:
                                            job['key_responsibilities']
                                                as List<dynamic>,
                                        jobReq: job['job_requirements']
                                            as Map<String, dynamic>,
                                        salary: job['salary'],
                                        currentVacancy: job['vacancy'],
                                        workLocation:
                                            job['location'].toString(),
                                        companywebsite:
                                            job['company_website'].toString(),
                                        datePosted:
                                            job['created_at'].toString(),
                                        companyImage:
                                            job['company_profile_image']
                                                .toString(),
                                      );
                                    },
                                  ));
                                } catch (error) {
                                  print(
                                      "Error in onTap: $error"); // Handle navigation errors
                                }
                              },
                              child: LatestJobCard(
                                firmname: job['company_name'].toString(),
                                jobTitle: job['title'].toString(),
                                jobSummary: job['job_summary'].toString(),
                                expLevel: job['experience_level'].toString(),
                                jobMode: job['job_mode'].toString(),
                                jobType: job['job_type'].toString(),
                                datePosted: job['created_at'].toString(),
                                companyImage:
                                    job['company_profile_image'].toString(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Add pagination buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PaginatedButton(
                        onPressed: () async {
                          if (_currentPage > 1) {
                            setState(() => _currentPage--);
                            await _fetchFilteredJobs(_currentPage);
                          }
                        },
                        child: const Text('Previous'),
                      ),
                      const SizedBox(width: 20),
                      Text('Page $_currentPage of $_totalPages'),
                      const SizedBox(width: 20),
                      PaginatedButton(
                        onPressed: () async {
                          if (_currentPage < _totalPages!) {
                            setState(() => _currentPage++);
                            await _fetchFilteredJobs(_currentPage);
                          }
                        },
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Create a PaginatedButton widget
class PaginatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  PaginatedButton({required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

//  Future<List<dynamic>> fetchFilteredJobs({
//   String? selectedJobType,
//   String? selectedSalary,
//   String? selectedExperience,
//   String? selectedWorkMode,
//   String? selectedLocation,
//   int? pageNumber,
//   int pageSize = 8,
// }) async {
//   int? minSalary;
//   int? maxSalary;

//   // Handle salary splitting logic
//   if (selectedSalary != "Salary" && selectedSalary != null) {
//     List<String> salaryParts = selectedSalary.split('-');
//     if (salaryParts.length == 2) {
//       minSalary = int.tryParse(salaryParts[0]);
//       maxSalary = int.tryParse(salaryParts[1]);
//     }
//   }

//   // Build query parameters for the request
//   final queryParameters = {
//     if (selectedWorkMode != "Work Mode" && selectedWorkMode != null)
//       'workMode': selectedWorkMode,
//     if (selectedJobType != "Job Type" && selectedJobType != null)
//       'jobType': selectedJobType,
//     if (selectedLocation != "Location" && selectedLocation != null)
//       'location': selectedLocation,
//     if (selectedExperience != "Experience" && selectedExperience != null)
//       'experienceLevel': selectedExperience,
//     if (minSalary != null && maxSalary != null)
//       'minSalary': minSalary.toString(),
//     if (minSalary != null && maxSalary != null)
//       'maxSalary': maxSalary.toString(),
//     if (pageNumber != null) 'page': pageNumber.toString(),
//     'pageSize': pageSize.toString(), // Always pass page size
//   };

//   // Construct URI
//   final uri = Uri.parse('$baseUrl2/job/filter')
//       .replace(queryParameters: queryParameters);

//   try {
//     final response = await http.get(uri);

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       if (data['message'] == 'Filter Success') {
//         return data['data'];
//       } else {
//         print("Unexpected response message: ${data['message']}");
//         throw Exception("Failed to fetch filtered jobs");
//       }
//     } else {
//       print("Error: ${response.statusCode}, Body: ${response.body}");
//       throw Exception("Failed to fetch filtered jobs");
//     }
//   } catch (e) {
//     print("Error fetching filtered jobs: $e");
//     rethrow;
//   }
// }

class LatestJobCard extends StatefulWidget {
  final String jobTitle;
  final String jobSummary;
  final String firmname;
  final String expLevel;
  final String jobMode;
  final String jobType;
  final String companyImage;
  final String datePosted;

  LatestJobCard({
    required this.jobTitle,
    required this.jobSummary,
    required this.expLevel,
    required this.firmname,
    required this.jobMode,
    required this.jobType,
    required this.companyImage,
    required this.datePosted,
  });

  @override
  _LatestJobCardState createState() => _LatestJobCardState();
}

class _LatestJobCardState extends State<LatestJobCard> {
  bool _isApplied = false;
  String calculateDaysAgo(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;

    if (days > 0) {
      return 'posted $days days ago';
    } else if (hours > 0) {
      return 'posted $hours hours ago';
    } else if (minutes > 0) {
      return 'posted $minutes minutes ago';
    } else {
      return 'posted just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 20, left: 10),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: black,
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage('$baseUrl2${widget.companyImage}'),
                  ),
                  Column(
                    children: [
                      Text(
                        widget.jobTitle,
                        style: AppTextStyle.postheadtxt,
                      ),
                      Text(
                        widget.firmname,
                        style: AppTextStyle.tactext,
                      ),
                    ],
                  ),
                  const Image(
                    image: AssetImage(likePng),
                    color: black,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.jobSummary,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Requirments(txt: widget.expLevel),
                Requirments(txt: widget.jobMode),
                Requirments(txt: widget.jobType),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isApplied = true;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        color: _isApplied ? green : green,
                      ),
                      child: Center(
                        child: Text(
                          _isApplied ? "Applied" : "Apply for this job",
                          style: AppTextStyle.applytxt,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Image(image: AssetImage(clockPng)),
                      ),
                      // Text(calculateDaysAgo('2024-09-05T10:34:35.000Z'))
                      Text(calculateDaysAgo(widget.datePosted))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget Requirments({txt}) {
  return Container(
    height: 20,
    width: 90,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      color: green,
    ),
    child: Center(
        child: Text(
      txt,
      style: AppTextStyle.buttontxt,
    )),
  );
}
