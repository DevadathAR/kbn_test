import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

class HomeFilterBox extends StatefulWidget {
    final Function(List<dynamic>) onFilterApplied;
      HomeFilterBox({required this.onFilterApplied});


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
    "300000-above"
  ];  List<String> experiences = ["Experience"];
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

    Future<void> fetchFilteredJobs() async {
    // Extract min and max salary if a valid salary range is selected
    int? minSalary;
    int? maxSalary;

    if (selectedSalary != "Salary") {
      List<String> salaryParts = selectedSalary.split('-');
      if (salaryParts.length == 2) {
        minSalary = int.tryParse(salaryParts[0]);
        maxSalary = int.tryParse(salaryParts[1]);
      }
    }

    final queryParameters = {
      if (selectedWorkMode != "Work Mode") 'workMode': selectedWorkMode,
      if (selectedJobType != "Job Type") 'jobType': selectedJobType,
      if (selectedLocation != "Location") 'location': selectedLocation,
      if (selectedExperience != "Experience")
        'experienceLevel': selectedExperience,
      if (minSalary != null && maxSalary != null)
        'minSalary': minSalary.toString(),
      if (minSalary != null && maxSalary != null)
        'maxSalary': maxSalary.toString(),
    };

    final uri = Uri.parse('http://192.168.29.197:5500/job/filter')
        .replace(queryParameters: queryParameters);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // print(data);
        if (data['message'] == 'Filter Success') {
          final List<dynamic> jobs = data['data'];

          widget.onFilterApplied(jobs); // Call the callback with filtered jobs
        }
      } else {
        throw Exception("Failed to fetch filtered jobs");
      }
    } catch (e) {
      print("Error fetching filtered jobs: $e");
    }
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