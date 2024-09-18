import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/veiw/auth/signUp.dart';
import 'package:kbn_test/veiw/auth/user_auth/userLogin.dart';
import 'package:kbn_test/veiw/screen/AdminScreen/adminHome.dart';
import 'package:kbn_test/veiw/screen/AdminScreen/adminLogin.dart';
import 'package:kbn_test/veiw/screen/companyScreen/cmpny_home.dart';
import 'package:kbn_test/veiw/auth/company_auth/cmpny_login.dart';
import 'package:kbn_test/veiw/screen/companyScreen/companyProfile.dart';
import 'package:kbn_test/veiw/screen/userScreen/home.dart';
import 'package:kbn_test/veiw/screen/userScreen/jobDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'veiw/auth/company_auth/testPage.dart';

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
      home: FutureBuilder(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data is String) {
            return const CompanyLoginPage();
          } else {
            //Role Based navigation
            switch (snapshot.data) {
              case 'Company':
                return const CompanyHomePage();
              case 'Applicant':
                return const UserHome();
              case 'Admin':
                return const AdminHomePage();
              default:
                return const CompanyLoginPage();
            }
            // return const CompanyLoginPage();
          }
        },
      ),
      // routes: {
      //   '/home': (context) => const CompanyHomePage(),
      //   '/login': (context) => const CompanyLoginPage(),
      //   // Add other routes here
      // },
    );
  }

  // Future<String?> _checkLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString('token');
  //   if (token == null) {
  //     return null;
  //   } else {
  //     ApiServices.headers['Authorization'] = "Bearer $token";

  //     // print('token:-$token');
  //     var userDetailsResponse = await ApiServices.fetchUserDetails();
  //     userDetails = userDetailsResponse;

  //     return null;
  //   }
  // }

  Future<String?> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      return null; // Not logged in
    } else {
      ApiServices.headers['Authorization'] = "Bearer $token";

      var userDetailsResponse = await ApiServices.fetchUserDetails();
      userDetails = userDetailsResponse;

      return null;
    }
  }
}
