import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';

class HomeFilterBox extends StatefulWidget {
  final Function(List<dynamic>) onFilterApplied;

  const HomeFilterBox({Key? key, required this.onFilterApplied})
      : super(key: key);

  @override
  _HomeFilterBoxState createState() => _HomeFilterBoxState();
}

class _HomeFilterBoxState extends State<HomeFilterBox> {
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
    _fetchFilteredJobs(); // Fetch jobs initially
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
