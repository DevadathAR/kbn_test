import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

class HomeFilterBox extends StatefulWidget {
  @override
  _HomeFilterBoxState createState() => _HomeFilterBoxState();
}

class _HomeFilterBoxState extends State<HomeFilterBox> {
  List<String> jobTypes = ["Job Type"];
  List<String> salaryRanges = ["Salary"];
  List<String> experiences = ["Experience"];
  List<String> workModes = ["Work Mode"];
  List<String> locations = ["Location"];

  String selectedJobType = "Job Type";
  String selectedSalary = "Salary";
  String selectedExperience = "Experience";
  String selectedWorkMode = "Work Mode";
  String selectedLocation = "Location";

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFilterData();
  }

  Future<void> fetchFilterData() async {
    final url = Uri.parse('http://192.168.29.197:5500/job/filter');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['message'] == 'Filter Success') {
          final List<dynamic> jobs = data['data'];

          setState(() {
            jobTypes = ["Job Type"] +
                jobs.map((job) => job['job_type'].toString()).toSet().toList();
            experiences = ["Experience"] +
                jobs
                    .map((job) => job['experience_level'].toString())
                    .toSet()
                    .toList();
            workModes = ["Work Mode"] +
                jobs.map((job) => job['job_mode'].toString()).toSet().toList();
            locations = ["Location"] +
                jobs.map((job) => job['location'].toString()).toSet().toList();

            // Explicitly cast salaries to int and group them into ranges
            salaryRanges = ["Salary"] +
                getSalaryRanges(
                    jobs.map((job) => job['salary'] as int).toList());
            isLoading = false;
          });
        }
      } else {
        throw Exception("Failed to load filter data");
      }
    } catch (e) {
      print("Error fetching filter data: $e");
    }
  }

  // Function to create predefined salary ranges
  List<String> getSalaryRanges(List<int> salaries) {
    List<String> ranges = [];

    // Define the salary ranges
    List<Map<String, int>> rangeLimits = [
      {"min": 10000, "max": 30000},
      {"min": 30000, "max": 50000},
      {"min": 50000, "max": 75000},
      {"min": 100000, "max": 150000}
    ];

    // Add all ranges regardless of actual salary data
    for (var range in rangeLimits) {
      final min = range['min']!;
      final max = range['max']!;

      ranges.add("\$$min - \$$max");
    }

    return ranges;
  }

  Future<void> fetchFilteredJobs() async {
    final url = Uri.parse(
        // 'http://192.168.29.197:5500/job/filter?jobType=${Uri.encodeComponent(selectedJobType)}&minSalary=${_getMinSalary()}&maxSalary=${_getMaxSalary()}&experienceLevel=${Uri.encodeComponent(selectedExperience)}&workMode=${Uri.encodeComponent(selectedWorkMode)}&location=${Uri.encodeComponent(selectedLocation)}');
        'http://192.168.29.197:5500/job/filter?&workMode=${Uri.encodeComponent(selectedWorkMode)}');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        if (data['message'] == 'Filter Success') {
          // Handle the filtered data
          final List<dynamic> jobs = data['data'];

          setState(() {
            // Update the UI with filtered job data if needed
            // e.g., update a list of jobs to display
          });
        }
      } else {
        throw Exception("Failed to fetch filtered jobs");
      }
    } catch (e) {
      print("Error fetching filtered jobs: $e");
    }
  }

  // Extract min and max salary from the selected range
  int _getMinSalary() {
    if (selectedSalary == "Salary") return 0;

    final parts = selectedSalary.split(" - ");
    return int.parse(parts[0].replaceAll(',', '').replaceAll('\$', ''));
  }

  int _getMaxSalary() {
    if (selectedSalary == "Salary")
      return 100000000; // Set a high number if no specific range is selected

    final parts = selectedSalary.split(" - ");
    return int.parse(parts[1].replaceAll(',', '').replaceAll('\$', ''));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            height: 100,
            width: size.width * 1,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              color: tealblue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildDropdown(jobTypes, selectedJobType, (newValue) {
                  setState(() {
                    selectedJobType = newValue!;
                    fetchFilteredJobs(); // Fetch filtered jobs when selection changes
                  });
                }),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: VerticalDivider(),
                ),
                buildDropdown(salaryRanges, selectedSalary, (newValue) {
                  setState(() {
                    selectedSalary = newValue!;
                    fetchFilteredJobs(); // Fetch filtered jobs when selection changes
                  });
                }),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: VerticalDivider(),
                ),
                buildDropdown(experiences, selectedExperience, (newValue) {
                  setState(() {
                    selectedExperience = newValue!;
                    fetchFilteredJobs(); // Fetch filtered jobs when selection changes
                  });
                }),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: VerticalDivider(),
                ),
                buildDropdown(workModes, selectedWorkMode, (newValue) {
                  setState(() {
                    selectedWorkMode = newValue!;
                    fetchFilteredJobs(); // Fetch filtered jobs when selection changes
                  });
                }),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: VerticalDivider(),
                ),
                buildDropdown(locations, selectedLocation, (newValue) {
                  setState(() {
                    selectedLocation = newValue!;
                    fetchFilteredJobs(); // Fetch filtered jobs when selection changes
                  });
                }),
              ],
            ),
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
          child: Text(
            value,
            style: AppTextStyle.flitertxt,
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
