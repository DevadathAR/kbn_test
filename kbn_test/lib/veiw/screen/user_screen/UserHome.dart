import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kbn_test/service/api_service.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/user_auth/UserLoginPage.dart';
import 'package:kbn_test/veiw/screen/user_screen/JobDetails.dart';
import 'package:kbn_test/veiw/screen/user_screen/jobCards.dart';
import 'package:kbn_test/veiw/screen/user_screen/termsandcond_applicant.dart';
import 'package:kbn_test/veiw/widgets/home_appbar_box.dart';
import 'package:kbn_test/veiw/widgets/home_filter_box.dart';
import 'package:kbn_test/veiw/widgets/upload_resume.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHome extends StatefulWidget {
  const  UserHome({super.key});

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List<dynamic> _jobs = [];
  int _currentPage = 1;
  int? _totalPages = 1;

  bool _shouldShowUploadResume = false; // Boolean to track resume availability
  Map<String, dynamic>? userDetails; // Nullable userDetails

  @override
  void initState() {
    super.initState();
    _fetchJobTitles();
    _checkResumeLink(); // Check if the resume link exists when initializing
    _fetchUserDetails(); // Fetch user details to use in the UI
  }

  Future<void> _fetchUserDetails() async {
    try {
      var response = await ApiServices.fetchUserDetails();
      setState(() {
        userDetails = response;
      });
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  // Method to check if user has a resume link
  Future<void> _checkResumeLink() async {
    try {
      var userDetailsResponse = await ApiServices.fetchUserDetails();
      var resumeLink = userDetailsResponse['user']['resumeLink'];

      setState(() {
        _shouldShowUploadResume = resumeLink == null || resumeLink.isEmpty;
      });
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  // Method to recheck resume link after resume is uploaded
  Future<void> _recheckResumeLink() async {
    await _checkResumeLink(); // Recheck the resume link
  }

  Future<void> _fetchJobTitles() async {
    try {
      var jobs = await ApiServices.fetchJobTitles();
      setState(() {
        _jobs = jobs;
        _totalPages = ((jobs.length / 8) + 1).ceil(); // Calculate total pages
      });
    } catch (e) {
      print('Error fetching job titles: $e');
    }
  }

 


  Future<List<dynamic>> _fetchFilteredJobs(int pageNumber) async {
    try {
      var response = await ApiServices.fetchFilteredJobs(
        pageNumber: pageNumber,
        pageSize: 8,
      );

      if (response != null && response is Map<String, dynamic>) {
        List<dynamic> filteredJobs = response['data'] as List<dynamic>;

        setState(() {
          _jobs = filteredJobs;
          int totalJobs = response['total_jobs'] ?? 0; // Default to 0 if not present
          _totalPages = (totalJobs / 8).ceil(); // Calculate total pages
        });

        return filteredJobs;
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      print('Error fetching filtered jobs: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Image(image: AssetImage(kbnLogo))),
                  HomeAppBarBox(
                    context,
                    profileImage: userDetails != null && userDetails!['user'] != null
                        ? "${baseUrl}/${userDetails!['user']['profile_image']}"
                        : '', // Check for null before using
                    T_and_C: const TaC(),
                    logOutTo: const UserLoginPage(),
                    termscolor: white,
                  ),
                  const SizedBox(height: 10),
                  HomeFilterBox(
                    onFilterApplied: (filteredJobs) {
                      setState(() {
                        _jobs = filteredJobs;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Text(
                      latestjob,
                      style: AppTextStyle.tactexthead,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 10,
                          childAspectRatio: 261 / 190,
                        ),
                        itemCount: _jobs.length,
                        itemBuilder: (context, index) {
                          final job = _jobs[index];
                          return GestureDetector(
                            onTap: () async {
                              try {
                                await ApiServices.postJobDetails(
                                    job['jobId'], job['companyId']);
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return JobDetails(
                                      jobId: job['jobId'],
                                      companyId: job['companyId'],
                                      firmname: job['company_name'].toString(),
                                      jobTitle: job['title'].toString(),
                                      jobSummary: job['job_summary'].toString(),
                                      expLevel: job['experience_level'].toString(),
                                      jobMode: job['job_mode'].toString(),
                                      jobType: job['job_type'].toString(),
                                      keyResponsibilities: job['key_responsibilities'] as List<dynamic>,
                                      jobReq: job['job_requirements'] as Map<String, dynamic>,
                                      salary: job['salary'],
                                      currentVacancy: job['vacancy'],
                                      workLocation: job['location'].toString(),
                                      companywebsite: job['company_website'].toString(),
                                      datePosted: job['created_at'].toString(),
                                      companyImage: job['company_profile_image'],
                                      status: job['application_status'].toString(),
                                    );
                                  },
                                ));
                              } catch (error) {
                                print('Error in onTap: $error');
                              }
                            },
                            child: LatestJobCard(
                              firmname: job['company_name'].toString(),
                              jobTitle: job['title'].toString(),
                              jobSummary: job['job_summary'].toString(),
                              expLevel: job['experience_level'].toString(),
                              jobMode: job['job_mode'].toString(),
                              jobType: job['job_type'].toString(),
                              companyImage: job['company_profile_image'].toString(),
                              datePosted: job['created_at'].toString(),
                              status: job['application_status'].toString(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
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
          // Conditionally show UploadMyResume based on resume availability
          if (_shouldShowUploadResume)
            UploadMyResume(
              onResumeUploaded: () async {
                await _recheckResumeLink(); // Call to recheck resume link after upload
              },
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
