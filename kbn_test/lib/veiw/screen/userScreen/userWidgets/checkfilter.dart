// import 'package:flutter/material.dart';
// import 'package:kbn_test/service/apiServices.dart';
// import 'package:kbn_test/utilities/assets_path.dart';
// import 'package:kbn_test/utilities/colors.dart';
// import 'package:kbn_test/utilities/const.dart';
// import 'package:kbn_test/utilities/text_style.dart';

// class HomeFilterBox1 extends StatefulWidget {
//   final Function(List<dynamic>) onFilterApplied;
//   const HomeFilterBox1({super.key, required this.onFilterApplied});

//   @override
//   _HomeFilterBox1State createState() => _HomeFilterBox1State();
// }

// class _HomeFilterBox1State extends State<HomeFilterBox1> {
//   List<String> jobTypes = ["Job Type"];
//   List<String> salaryRanges = [
//     "Salary",
//     "0-25000",
//     "25000-50000",
//     "50000-75000",
//     "75000-100000",
//     "100000-300000",
//   ];
//   List<String> experiences = ["Experience"];
//   List<String> workModes = ["Work Mode"];
//   List<String> locations = ["Location"];

//   // Map to store currently selected filter values
//   Map<String, String> selectedFilters = {
//     'jobTypes': "Job Type",
//     'salaryRanges': "Salary",
//     'experiences': "Experience",
//     'workModes': "Work Mode",
//     'locations': "Location",
//   };

//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchDropdownBoxItems();
//   }

//   Future<void> fetchDropdownBoxItems() async {
//     try {
//       print("Fetching dropdown box items...");
//       final dropBoxItems = await ApiServices.fetchDropdownBoxItems();
//       print("Dropdown box items fetched: $dropBoxItems");
//       setState(() {
//         jobTypes = ["Job Type"] + dropBoxItems['jobTypes']!;
//         experiences = ["Experience"] + dropBoxItems['experiences']!;
//         locations = ["Location"] + dropBoxItems['locations']!;
//         workModes = ["Work Mode"] + dropBoxItems['workModes']!;
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> fetchFilteredJobs() async {
//     try {
//       final jobsResponse = await ApiServices.fetchFilteredJobs(
//         selectedJobType: selectedFilters['jobTypes']!,
//         selectedSalary: selectedFilters['salaryRanges']!,
//         selectedExperience: selectedFilters['experiences']!,
//         selectedWorkMode: selectedFilters['workModes']!,
//         selectedLocation: selectedFilters['locations']!,
//       );

//       final jobs = jobsResponse['data'] as List<dynamic>;
//       widget.onFilterApplied(jobs);
//     } catch (e) {
//       print("Error fetching filtered jobs: $e");
//     }
//   }

//   void onCheckboxTap(String filterName, String filterValue) {
//     setState(() {
//       selectedFilters[filterName] = filterValue;
//     });
//     fetchFilteredJobs();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return isLoading
//         ? const Center(child: CircularProgressIndicator())
//         : Container(
//             height: size.height * 0.5, // Increased height
//             width: size.width * 1,
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(2)),
//               color: tealblue,
//             ),
//             child: (size.width >= 900)
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       buildCheckboxFilter(jobTypes, 'jobTypes'),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 20),
//                         child: VerticalDivider(),
//                       ),
//                       buildCheckboxFilter(salaryRanges, 'salaryRanges'),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 20),
//                         child: VerticalDivider(),
//                       ),
//                       buildCheckboxFilter(experiences, 'experiences'),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 20),
//                         child: VerticalDivider(),
//                       ),
//                       buildCheckboxFilter(workModes, 'workModes'),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 20),
//                         child: VerticalDivider(),
//                       ),
//                       buildCheckboxFilter(locations, 'locations'),
//                     ],
//                   )
//                 : const Padding(
//                     padding: EdgeInsets.only(left: 25),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Image(image: AssetImage(filterPng)),
//                         Padding(
//                           padding: EdgeInsets.only(left: 15),
//                           child: Text(
//                             filters,
//                             style: AppTextStyle.flitertxt,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//           );
//   }

//   Widget buildCheckboxFilter(List<String> items, String filterName) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           items.first,
//           style: AppTextStyle.flitertxt,
//         ),
//         Expanded(
//           child: ListView(
//             children: items.sublist(1).map((item) {
//               return CheckboxListTile(
//                 title: Text(
//                   item,
//                   style: TextStyle(color: Colors.white), // For better visibility
//                 ),
//                 value: selectedFilters[filterName] == item,
//                 onChanged: (bool? isChecked) {
//                   if (isChecked == true) {
//                     onCheckboxTap(filterName, item); // Pass the item string
//                   }
//                 },
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }
