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

// List<dynamic> dropboxes =[];

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

  @override
  void initState() {
    super.initState();
    fetchDropdownBoxItems();
  }

  Future<void> fetchDropdownBoxItems() async {
  try {
    print("Fetching dropdown box items...");
    final dropBoxItems = await ApiServices.fetchDropdownBoxItems();
    print("Dropdown box items fetched: $dropBoxItems");
    setState(() {
      
      
      jobTypes = ["Job Type"] + dropBoxItems['jobTypes']!;
      print("jobTypes: $jobTypes"); // Add this line
      experiences = ["Experience"] + dropBoxItems['experiences']!;
      print("experiences: $experiences"); // Add this line
      locations = ["Location"] + dropBoxItems['locations']!;
      print("locations: $locations"); // Add this line
      workModes = ["Work Mode"] + dropBoxItems['workModes']!;
      print("workModes: $workModes"); // Add this line




      isLoading = false;
    });
  } catch (e) {
    print("Error: $e");
    setState(() {
      
      isLoading = false;

    });
  }
}

  Future<void> fetchFilteredJobs() async {
    try {
      final jobsResponse = await ApiServices.fetchFilteredJobs(
        selectedJobType: selectedJobType,
        selectedSalary: selectedSalary,
        selectedExperience: selectedExperience,
        selectedWorkMode: selectedWorkMode,
        selectedLocation: selectedLocation,
      );

      final jobs = jobsResponse['data'] as List<dynamic>;
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
            width: size.width,
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

  Widget buildDropdown(List<String> items, String selectedItem, ValueChanged<String?> onChanged) {
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