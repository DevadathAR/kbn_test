import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget HomeFilterBox(BuildContext context) {
  Size size = MediaQuery.of(context).size;

  // Sample data for dropdowns with labels as the first item
  final jobTypes = ["Job Type", "Full-time", "Part-time", "Contract"];
  final salaryRanges = [    "Salary",    "\$20k - \$30k",    "\$30k - \$40k",    "\$40k - \$50k"  ];
  final experiences = ["Experience", "0-1 years", "2-5 years", "5+ years"];
  final workModes = ["Work Mode", "Remote", "On-site", "Hybrid"];
  final locations = ["Location", "New York", "San Francisco", "Los Angeles"];

  String selectedJobType = jobTypes[0];
  String selectedSalary = salaryRanges[0];
  String selectedExperience = experiences[0];
  String selectedWorkMode = workModes[0];
  String selectedLocation = locations[0];

  return Container(
    height: 100,
    width: size.width - 230,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(2)),
      color: tealblue,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DropdownButton<String>(
          dropdownColor: tealblue,
          value: selectedJobType,
          iconEnabledColor: homecolor,
          underline: SizedBox.shrink(),
          items: jobTypes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyle.flitertxt,
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            selectedJobType = newValue!;
          },
        ),
        DropdownButton<String>(
          dropdownColor: tealblue,
          value: selectedSalary,
          iconEnabledColor: homecolor,
          underline: SizedBox.shrink(),
          items: salaryRanges.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyle.flitertxt,
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            selectedSalary = newValue!;
          },
        ),
        DropdownButton<String>(
          dropdownColor: tealblue,
          value: selectedExperience,
          iconEnabledColor: homecolor,
          underline: SizedBox.shrink(),
          items: experiences.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyle.flitertxt,
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            selectedExperience = newValue!;
          },
        ),
        DropdownButton<String>(
          dropdownColor: tealblue,
          value: selectedWorkMode,
          iconEnabledColor: homecolor,
          underline: SizedBox.shrink(),
          items: workModes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyle.flitertxt,
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            selectedWorkMode = newValue!;
          },
        ),
        DropdownButton<String>(
          dropdownColor: tealblue,
          value: selectedLocation,
          iconEnabledColor: homecolor,
          underline: SizedBox.shrink(),
          items: locations.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyle.flitertxt,
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            selectedLocation = newValue!;
          },
        ),
      ],
    ),
  );
}
