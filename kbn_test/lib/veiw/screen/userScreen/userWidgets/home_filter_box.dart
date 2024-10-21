import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/widgets_common/home_appbar_box.dart';

class HomeFilterBox extends StatefulWidget {
  final Function(List<dynamic>) onFilterApplied;


  final Widget? T_and_C;
  final Color? termscolor;
  final Widget? profilePage;
  final String? profileImage;
final Widget? home;
  const HomeFilterBox({Key? key, required this.onFilterApplied,
 required this.T_and_C,
  required this.termscolor,
 this.profilePage,
  required this.profileImage,
  this.home

  })
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
                          buildDropdown(salaryRanges, selectedSalary,
                              (newValue) {
                            setState(() {
                              selectedSalary = newValue!;
                              _fetchFilteredJobs();
                            });
                          }),
                          const VerticalDivider(),
                          buildDropdown(experiences, selectedExperience,
                              (newValue) {
                            setState(() {
                              selectedExperience = newValue!;
                              _fetchFilteredJobs();
                            });
                          }),
                          const VerticalDivider(),
                          buildDropdown(workModes, selectedWorkMode,
                              (newValue) {
                            setState(() {
                              selectedWorkMode = newValue!;
                              _fetchFilteredJobs();
                            });
                          }),
                          const VerticalDivider(),
                          buildDropdown(locations, selectedLocation,
                              (newValue) {
                            setState(() {
                              selectedLocation = newValue!;
                              _fetchFilteredJobs();
                            });
                          }),
                        ],
                      )
                    : 


                   
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              GestureDetector(
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
                                  "Filters",
                                  style: AppTextStyle.sixteen_w400_white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),


const Spacer(),

              //Terms and Conditions
              AppBarButtons(
                context,
                icon: termsPng,
                nextPage:widget. T_and_C,
                iconcolor: widget.termscolor,
              ),
              SizedBox(width: size.width * 0.02),
              //profileButton
              AppBarButtons(context,
                  icon: unknownPng,
                  uploadedImage: widget. profileImage,
                  nextPage: widget. profilePage
                  ),
              SizedBox(width: size.width * 0.02),
              // LogOut
              AppBarButtons(context,
                  icon: logOutPng,
                  isLogout: true,
                  logOutTo: const CompanyLoginPage(),
                  backHome: widget.home
                  ),
            ],
          ),
                    
                    
                    
                    
              ),
              const SizedBox(height: 10),
              // if (size.width > 900)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: goToFilteredPreviousPage,
                      child: const Text('<<'),
                    ),
                    const SizedBox(width: 20),
                    Text('Page $currentPage of $totalPages'),
                    const SizedBox(width: 20),
                    TextButton(
                      onPressed: goToFilteredNextPage,
                      child: const Text('>>'),
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
          child: Text(value, style: AppTextStyle.sixteen_w400_white),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
