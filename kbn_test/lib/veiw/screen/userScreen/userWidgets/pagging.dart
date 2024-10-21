import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';

class Pagging extends StatefulWidget {
  final Function(List<dynamic>) onFilterApplied;

  const Pagging({
    Key? key,
    required this.onFilterApplied,
  }) : super(key: key);

  @override
  _PaggingState createState() => _PaggingState();
}

class _PaggingState extends State<Pagging> {

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
    _fetchFilteredJobs(); // Fetch jobs initially
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
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Row(
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
          );
  }
}
