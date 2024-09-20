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

  @override
  void initState() {
    super.initState();
    fetchDropdownBoxItems();
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
        ? const Center(child: CircularProgressIndicator())
        : Container(
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
                          fetchFilteredJobs();
                        });
                      }),
                      const VerticalDivider(),
                      buildDropdown(salaryRanges, selectedSalary, (newValue) {
                        setState(() {
                          selectedSalary = newValue!;
                          fetchFilteredJobs();
                        });
                      }),
                      const VerticalDivider(),
                      buildDropdown(experiences, selectedExperience,
                          (newValue) {
                        setState(() {
                          selectedExperience = newValue!;
                          fetchFilteredJobs();
                        });
                      }),
                      const VerticalDivider(),
                      buildDropdown(workModes, selectedWorkMode, (newValue) {
                        setState(() {
                          selectedWorkMode = newValue!;
                          fetchFilteredJobs();
                        });
                      }),
                      const VerticalDivider(),
                      buildDropdown(locations, selectedLocation, (newValue) {
                        setState(() {
                          selectedLocation = newValue!;
                          fetchFilteredJobs();
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
