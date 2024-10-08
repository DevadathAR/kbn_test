import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/modelClass.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Apiresponse? companyData; // To hold the API response
  bool isLoading = true; // To manage the loading state

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // Function to fetch data from API
  void _fetchData() async {
    try {
      // Assuming you're passing companyId as 1 for testing
      Apiresponse response = await ApiServices.companyData();

      print(response);
      setState(() {
        companyData = response;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
      // Optionally show a snackbar or dialog to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Data'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear(); // Clear the login status

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const CompanyLoginPage()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : companyData == null
              ? const Center(child: Text('No data available'))
              : _buildCompanyDetails(companyData!),
    );
  }

  // A widget to display company details
  Widget _buildCompanyDetails(Apiresponse data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          Text(
              'Company Position: ${data.companyData.commonData.companyPosition}',
              style: const TextStyle(fontSize: 16)),
          Text(
              'Total Applicants: ${data.companyData.commonData.applicantsTotal.thisMonth}',
              style: const TextStyle(fontSize: 16)),
          Text(
              'Selected Applicants: ${data.companyData.commonData.applicantsSelected.thisMonth}',
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          // Displaying most applied job
          Text(
              'Most Applied Job: ${data.companyData.commonData.mostAppliedJob.title}',
              style: const TextStyle(fontSize: 16)),
          Text(
              'Applicants Count: ${data.companyData.commonData.mostAppliedJob.applicantsCount}',
              style: const TextStyle(fontSize: 16)),
          Text('Growth: ${data.companyData.commonData.mostAppliedJob.growth}',
              style: const TextStyle(fontSize: 16)),
          // Add more details as needed
        ],
      ),
    );
  }
}
