import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/veiw/screen/AdminScreen/adminHome.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/AdminSection/adminHome.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/CompanySection/companyHome.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/chartWidget.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/CompanySection/CompanyScaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/companyScreen/cmpny_home.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/screen/userScreen/home.dart';
import 'package:kbn_test/veiw/screen/userScreen/jobDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "KBN_Test",
        debugShowCheckedModeBanner: false,
        home: // StatisticScreen(),

            CompanyHome()

        // AdminHome(),

        //  CompanyJobpage(),

        // Home(),

        //     FutureBuilder(
        //   future: _checkLoginStatus(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const CircularProgressIndicator();
        //     } else if (snapshot.hasData && snapshot.data is String) {
        //       // Role-Based navigation
        //       switch (snapshot.data) {
        //         case 'Company':
        //           return const CompanyHome();
        //         case 'Applicant':
        //           return const UserHome();
        //         case 'Admin':
        //           return const CompanyHome();
        //         default:
        //           return const CompanyLoginPage(); // Fallback
        //       }
        //     } else {
        //       return const CompanyLoginPage(); // Show login if no valid role
        //     }
        //   },
        // ),
        );
  }

  Future<String?> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? role = prefs.getString('role'); // Retrieve the role

    if (token == null) {
      return null; // Not logged in
    } else {
      ApiServices.headers['Authorization'] = "Bearer $token";

      var userDetailsResponse = await ApiServices.fetchUserDetails();
      userDetails = userDetailsResponse;

      print(userDetailsResponse);

      return role;
    }
  }
}
