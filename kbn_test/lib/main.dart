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
          } else if (snapshot.data == true) {
            return const AdminHomePage();
          } else {
            return const AdminLogIn();
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

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (token == null) {
      return false;
    } else {
      ApiServices.headers['Authorization'] = "Bearer $token";

      // print('token:-$token');
      var userDetailsResponse = await ApiServices.fetchUserDetails();
      userDetails = userDetailsResponse;

      return true;
    }
  }
}
