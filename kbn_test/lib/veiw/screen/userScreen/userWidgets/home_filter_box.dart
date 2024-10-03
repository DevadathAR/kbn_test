import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/userScreen/jobCards.dart';
import 'package:kbn_test/veiw/screen/userScreen/jobDetails.dart';

class HomeFilterBox extends StatefulWidget {
  final Function(List<dynamic>) onFilterApplied;

  const HomeFilterBox({Key? key, required this.onFilterApplied})
      : super(key: key);

  @override
  _HomeFilterBoxState createState() => _HomeFilterBoxState();
}

class _HomeFilterBoxState extends State<HomeFilterBox> {
    List<dynamic> _jobs = [];

  List<String> jobTypes = ["Job Type"];
  List<String> salaryRanges = [
    "Salary",
    "0-25000",
    "25000-50000",
    "50000-75000",
    "75000-100000",
    "100000-300000",
  ];
  List<String> experiences = ["Experience"];
  List<String> workModes = ["Work Mode"];
  List<String> locations = ["Location"];

  String selectedJobType = "Job Type";
  String selectedSalary = "Salary";
  String selectedExperience = "Experience";
  String selectedWorkMode = "Work Mode";
  String selectedLocation = "Location";

  bool isLoading = true;

  // Pagination state variables
  int currentPage = 1;
  int? totalPages = 1;

  @override
  void initState() {
    super.initState();
    fetchDropdownBoxItems();
    // _fetchFilteredJobs(); // Fetch jobs initially
  }

  Future<void> fetchDropdownBoxItems() async {
    try {
      final dropBoxItems = await ApiServices.fetchDropdownBoxItems();
      setState(() {
        jobTypes = ["Job Type"] + dropBoxItems['jobTypes']!;
        experiences = ["Experience"] + dropBoxItems['experiences']!;
        locations = ["Location"] + dropBoxItems['locations']!;
        workModes = ["Work Mode"] + dropBoxItems['workModes']!;
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchFilteredJobs() async {
    try {
      setState(() {
        isLoading = true;
      });

      // Fetch filtered jobs based on selected filters and current page
      final jobsResponse = await ApiServices.fetchFilteredJobs(
        selectedJobType: selectedJobType,
        selectedSalary: selectedSalary,
        selectedExperience: selectedExperience,
        selectedWorkMode: selectedWorkMode,
        selectedLocation: selectedLocation,
        pageNumber: currentPage,
      );

      final jobs = jobsResponse['data'] as List<dynamic>;
      final totalJobsPosted = jobsResponse['totalJobs'] as int;

      // Set total pages based on the total number of jobs
      setState(() {
        totalPages = (totalJobsPosted == 0) ? 1 : (totalJobsPosted / 8).ceil();
        widget.onFilterApplied(jobs); // Pass jobs to parent widget
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching filtered jobs: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void goToFilteredPreviousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
      _fetchFilteredJobs();
    }
  }

  void goToFilteredNextPage() {
    if (currentPage < totalPages!) {
      setState(() {
        currentPage++;
      });
      _fetchFilteredJobs();
    }
  }
  
  // int _getCrossAxisCount(Size size) {
  //   if (size.width < 900) return 1;
  //   if (size.width < 1200) return 2;
  //   if (size.width < 1600) return 3;
  //   return 4;
  // }

  // double _getChildAspectRatio(Size size) {
  //   if (size.width < 900) return size.width * 0.1 / size.width * 15;
  //   if (size.width < 1200) return size.width * 0.15 / size.width * 10;
  //   if (size.width < 1600) return size.width * 0.22 / size.width * 6;
  //   return size.width * 0.25 / size.width * 5;
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                height: 100,
                width: size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  color: tealblue,
                ),
                child: (size.width >= 900)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildDropdown(jobTypes, selectedJobType, (newValue) {
                            setState(() {
                              selectedJobType = newValue!;
                              _fetchFilteredJobs();
                            });
                          }),
                          const VerticalDivider(),
                          buildDropdown(salaryRanges, selectedSalary, (newValue) {
                            setState(() {
                              selectedSalary = newValue!;
                              _fetchFilteredJobs();
                            });
                          }),
                          const VerticalDivider(),
                          buildDropdown(
                              experiences, selectedExperience, (newValue) {
                            setState(() {
                              selectedExperience = newValue!;
                              _fetchFilteredJobs();
                            });
                          }),
                          const VerticalDivider(),
                          buildDropdown(workModes, selectedWorkMode, (newValue) {
                            setState(() {
                              selectedWorkMode = newValue!;
                              _fetchFilteredJobs();
                            });
                          }),
                          const VerticalDivider(),
                          buildDropdown(locations, selectedLocation, (newValue) {
                            setState(() {
                              selectedLocation = newValue!;
                              _fetchFilteredJobs();
                            });
                          }),
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(image: AssetImage(filterPng)),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  filters,
                                  style: AppTextStyle.flitertxt,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 10),


// Expanded(
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







              if(size.width>900)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: goToFilteredPreviousPage,
                    child: const Text('Previous'),
                  ),
                  const SizedBox(width: 20),
                  Text('Page $currentPage of $totalPages'),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: goToFilteredNextPage,
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          );
  }

  Widget buildDropdown(List<String> items, String selectedItem,
      ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      dropdownColor: tealblue,
      value: selectedItem,
      iconEnabledColor: homecolor,
      underline: const SizedBox.shrink(),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: AppTextStyle.flitertxt),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  
}
