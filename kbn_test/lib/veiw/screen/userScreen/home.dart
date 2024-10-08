import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/userScreen/userWidgets/jobCards.dart';
import 'package:kbn_test/veiw/screen/userScreen/jobDetails.dart';
import 'package:kbn_test/veiw/screen/userScreen/userT_n_C.dart';
import 'package:kbn_test/veiw/screen/userScreen/userWidgets/home_filter_box.dart';
import 'package:kbn_test/veiw/screen/userScreen/userWidgets/upload_resume.dart';
import 'package:kbn_test/veiw/widgets_common/home_appbar_box.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List<dynamic> _jobs = [];
  int _currentPage = 1;
  int? _totalPages = 1;
  bool _shouldShowUploadResume = false;
  bool _isLoading = true;

  // State for selected filters
  final List<String> _selectedJobTypes = [];
  final List<String> _selectedExperience = [];
  final List<String> _selectedWorkModes = [];
  final List<String> _selectedLocations = [];
  double _selectedSalaryStart = 0;
  double _selectedSalaryEnd = 300000; // Default upper limit for salary

  // State for filter items from API
  Map<String, List<String>> dropDownItems = {
    'jobTypes': [],
    'experiences': [],
    'locations': [],
    'workModes': [],
  };

  @override
  void initState() {
    super.initState();
    _fetchDropDownItems();
    _checkResumeLink();
    _fetchFilteredJobs(); // Initial fetch
  }

  Future<void> _checkResumeLink() async {
    try {
      var userDetails = await ApiServices.fetchUserDetails();
      var resumeLink = userDetails['user']['resumeLink'];

      setState(() {
        _shouldShowUploadResume = resumeLink == null || resumeLink.isEmpty;
      });
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  Future<void> _fetchDropDownItems() async {
    try {
      var items = await ApiServices.fetchDropdownBoxItems();
      setState(() {
        dropDownItems = items;
      });
    } catch (e) {
      print('Error fetching dropdown items: $e');
    }
  }

  Future<void> _fetchFilteredJobs() async {
    try {
      setState(() {
        _isLoading = true; // Show loading spinner
      });

      // Fetch filtered jobs based on the selected filters
      final jobsResponse = await ApiServices.fetchFilteredJobs(
        selectedJobType: _selectedJobTypes.isNotEmpty
            ? _selectedJobTypes.join(",")
            : "Job Type",
        selectedSalary:
            '${_selectedSalaryStart.toInt()}-${_selectedSalaryEnd.toInt()}', // Salary filter
        selectedExperience: _selectedExperience.isNotEmpty
            ? _selectedExperience.join(",")
            : "Experience",
        selectedWorkMode: _selectedWorkModes.isNotEmpty
            ? _selectedWorkModes.join(",")
            : "Work Mode",
        selectedLocation: _selectedLocations.isNotEmpty
            ? _selectedLocations.join(",")
            : "Location",
        pageNumber: _currentPage, // Pass the current page
      );

      // Extract jobs and total jobs from the response
      final jobs = jobsResponse['data'] as List<dynamic>;
      final totalJobsPosted = jobsResponse['totalJobs'] as int;

      setState(() {
        _jobs = jobs;
        // Calculate total pages based on the total number of jobs
        _totalPages = totalJobsPosted == 0 ? 1 : (totalJobsPosted / 8).ceil();
        _isLoading = false; // Hide loading spinner
      });
    } catch (e) {
      print("Error fetching filtered jobs: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
      });
      _fetchFilteredJobs(); // Fetch jobs for the previous page
    }
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages!) {
      setState(() {
        _currentPage++;
      });
      _fetchFilteredJobs(); // Fetch jobs for the next page
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
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
                          T_and_C: const user_T_n_C(),
                          termscolor: white,
                          profileImage:
                              "${ApiServices.baseUrl}/${userDetails['user']['profile_image']}",
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
                            style: AppTextStyle.twentyFour_W400,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: _getCrossAxisCount(size),
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 10,
                                childAspectRatio: _getChildAspectRatio(size),
                              ),
                              itemCount: _jobs.length,
                              itemBuilder: (context, index) {
                                final job = _jobs[index];
                                return GestureDetector(
                                  onTap: () async {
                                    try {
                                      await ApiServices.postJobDetails(
                                          job['jobId']);
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return JobDetails(
                                            jobId: job['jobId'],
                                            companyId: job['companyId'],
                                            firmname:
                                                job['company_name'].toString(),
                                            jobTitle: job['title'].toString(),
                                            jobSummary:
                                                job['job_summary'].toString(),
                                            expLevel: job['experience_level']
                                                .toString(),
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
                                                job['company_website']
                                                    .toString(),
                                            datePosted:
                                                job['created_at'].toString(),
                                            companyImage:
                                                job['company_profile_image'],
                                            status: job['application_status']
                                                .toString(),
                                          );
                                        },
                                      ));
                                    } catch (error) {
                                      print('Error in onTap: $error');
                                    }
                                    // Navigate to JobDetails
                                  },
                                  child: LatestJobCard(
                                    firmname: job['company_name'].toString(),
                                    jobTitle: job['title'].toString(),
                                    jobSummary: job['job_summary'].toString(),
                                    expLevel:
                                        job['experience_level'].toString(),
                                    jobMode: job['job_mode'].toString(),
                                    jobType: job['job_type'].toString(),
                                    companyImage:
                                        job['company_profile_image'].toString(),
                                    datePosted: job['created_at'].toString(),
                                    status:
                                        job['application_status'].toString(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // Pagination Controls
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PaginatedButton(
                              onPressed: _goToPreviousPage,
                              child: const Text('Previous'),
                            ),
                            const SizedBox(width: 20),
                            Text('Page $_currentPage of $_totalPages'),
                            const SizedBox(width: 20),
                            PaginatedButton(
                              onPressed: _goToNextPage,
                              child: const Text('Next'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (_shouldShowUploadResume)
                  UploadMyResume(
                    onResumeUploaded: () async {
                      await _checkResumeLink();
                    },
                  ),
              ],
            ),
      drawer: Padding(
        padding: EdgeInsets.only(top: size.width > 600 ? 230.0 : 210),
        child: Drawer(
          child: Container(
            height: size.height * 0.5,
            width: size.width * 0.25,
            color: tealblue,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildFilterSection('Job Type', dropDownItems['jobTypes'] ?? [],
                    _selectedJobTypes, (value) {
                  setState(() {
                    _selectedJobTypes.contains(value)
                        ? _selectedJobTypes.remove(value)
                        : _selectedJobTypes.add(value);
                    _fetchFilteredJobs();
                  });
                }),
                _buildFilterSection(
                    'Experience',
                    dropDownItems['experiences'] ?? [],
                    _selectedExperience, (value) {
                  setState(() {
                    _selectedExperience.contains(value)
                        ? _selectedExperience.remove(value)
                        : _selectedExperience.add(value);
                    _fetchFilteredJobs();
                  });
                }),
                _buildFilterSection(
                    'Work Mode',
                    dropDownItems['workModes'] ?? [],
                    _selectedWorkModes, (value) {
                  setState(() {
                    _selectedWorkModes.contains(value)
                        ? _selectedWorkModes.remove(value)
                        : _selectedWorkModes.add(value);
                    _fetchFilteredJobs();
                  });
                }),
                _buildFilterSection(
                    'Location',
                    dropDownItems['locations'] ?? [],
                    _selectedLocations, (value) {
                  setState(() {
                    _selectedLocations.contains(value)
                        ? _selectedLocations.remove(value)
                        : _selectedLocations.add(value);
                    _fetchFilteredJobs();
                  });
                }),
                _buildFilterSection(
                    'Salary', [], [], (value) {}), // Include salary filter here
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSalarySlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Salary Range:  ${_selectedSalaryStart.round()} - ${_selectedSalaryEnd.round()}',
            style: const TextStyle(color: Colors.white),
          ),
          RangeSlider(
            activeColor: white,
            inactiveColor: textGrey,
            values: RangeValues(_selectedSalaryStart, _selectedSalaryEnd),
            min: 0,
            max: 300000, // Adjust max salary as needed
            divisions: 10000,
            labels: RangeLabels(_selectedSalaryStart.round().toString(),
                _selectedSalaryEnd.round().toString()),
            onChanged: (RangeValues values) {
              setState(() {
                // Only allow changing the end value (maxSalary)
                _selectedSalaryStart = values.start;
                _selectedSalaryEnd = values.end;
                // Fetch the jobs whenever the salary range changes
                _fetchFilteredJobs();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(String label, List<String> items,
      List<String> selectedItems, ValueChanged<String> onChanged) {
    return ExpansionTile(
      title: Text(label, style: const TextStyle(color: Colors.white)),
      children: [
        if (label == 'Salary')
          _buildSalarySlider(), // Add salary slider for Salary section
        if (label != 'Salary')
          ...items.map((item) {
            return ListTile(
              leading: Checkbox(
                // focusColor: white,
                hoverColor: white,

                value: selectedItems.contains(item),
                onChanged: (bool? value) {
                  setState(() {
                    if (value != null && value) {
                      selectedItems.add(item);
                    } else {
                      selectedItems.remove(item);
                    }
                    _fetchFilteredJobs(); // Call job filtering whenever a checkbox is changed
                  });
                },
                activeColor: Colors.white,
                checkColor: tealblue,
              ),
              title: Text(item, style: const TextStyle(color: Colors.white)),
            );
          }),
      ],
    );
  }

  int _getCrossAxisCount(Size size) {
    if (size.width < 900) return 1;
    if (size.width < 1200) return 2;
    if (size.width < 1600) return 3;
    return 4;
  }

  double _getChildAspectRatio(Size size) {
    if (size.width < 900) return size.width * 0.1 / size.width * 15;
    if (size.width < 1200) return size.width * 0.15 / size.width * 10;
    if (size.width < 1600) return size.width * 0.22 / size.width * 6;
    return size.width * 0.25 / size.width * 5;
  }
}

// Create a PaginatedButton widget
class PaginatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const PaginatedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
