import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/companyHome.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/screen/userScreen/home.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KBN_Test",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        MonthYearPickerLocalizations.delegate, // Add this line
        // Add other localization delegates if necessary
      ],
      home: FutureBuilder(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator with a minimum width of 200 pixels
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 500, // Minimum width of 200 pixels
                ),
                child: const CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData && snapshot.data is String) {
            // Role-Based navigation
            switch (snapshot.data) {
              case 'Company':
                return const CompanyHome();
              case 'Applicant':
                return const UserHome();
              case 'Admin':
                return const CompanyHome();
              default:
                return const CompanyLoginPage(); // Fallback
            }
          } else {
            return const CompanyLoginPage(); // Show login if no valid role
          }
        },
      ),
    );
  }

  Future<String?> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? role = prefs.getString('role'); // Retrieve the role

    if (token == null) {
      return null; // Not logged in
    } else {
      // print(role);
      if (role != 'Admin') {
        isCompany = true;
      } else {
        isCompany = false;
      }
      ApiServices.headers['Authorization'] = "Bearer $token";
      var userDetailsResponse = await ApiServices.fetchUserDetails();
      userDetails = userDetailsResponse;
      return role;
    }
  }
}
