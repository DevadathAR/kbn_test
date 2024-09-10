import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kbn_test/service/api_service.dart';
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
    // "300000-above"
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

  @override
  void initState() {
    super.initState();
    fetchFilterData();
  }

  Future<void> fetchFilterData() async {
    try {
      final filters = await ApiServices.fetchFilterData();
      // log(jsonEncode(filters['jobTypes']));
      setState(() {
        jobTypes = ["Job Type"] + filters['jobTypes']!;
        experiences = ["Experience"] + filters['experiences']!;
        workModes = ["Work Mode"] + filters['workModes']!;
        locations = ["Location"] + filters['locations']!;
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> fetchFilteredJobs() async {
    try {
      final jobs = await ApiServices.fetchFilteredJobs(
        selectedJobType: selectedJobType,
        selectedSalary: selectedSalary,
        selectedExperience: selectedExperience,
        selectedWorkMode: selectedWorkMode,
        selectedLocation: selectedLocation,
      );
      widget.onFilterApplied(jobs);
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
                    fetchFilteredJobs();
                  });
                }),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: VerticalDivider(),
                ),
                buildDropdown(salaryRanges, selectedSalary, (newValue) {
                  setState(() {
                    selectedSalary = newValue!;
                    fetchFilteredJobs();
                  });
                }),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: VerticalDivider(),
                ),
                buildDropdown(experiences, selectedExperience, (newValue) {
                  setState(() {
                    selectedExperience = newValue!;
                    fetchFilteredJobs();
                  });
                }),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: VerticalDivider(),
                ),
                buildDropdown(workModes, selectedWorkMode, (newValue) {
                  setState(() {
                    selectedWorkMode = newValue!;
                    fetchFilteredJobs();
                  });
                }),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: VerticalDivider(),
                ),
                buildDropdown(locations, selectedLocation, (newValue) {
                  setState(() {
                    selectedLocation = newValue!;
                    fetchFilteredJobs();
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
