import 'package:flutter/material.dart';
import 'package:kbn_test/veiw/auth/signUp.dart';
import 'package:kbn_test/veiw/auth/user_auth/userLogin.dart';
import 'package:kbn_test/veiw/screen/AdminScreen/adminHome.dart';
import 'package:kbn_test/veiw/screen/AdminScreen/adminLogin.dart';
import 'package:kbn_test/veiw/screen/companyScreen/cmpny_home.dart';
import 'package:kbn_test/veiw/auth/company_auth/cmpny_login.dart';
import 'package:kbn_test/veiw/screen/companyScreen/companyProfile.dart';
import 'package:kbn_test/veiw/screen/userScreen/home.dart';
import 'package:kbn_test/veiw/screen/userScreen/jobDetails.dart';

import 'veiw/auth/company_auth/testPage.dart';

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
      home:
          // SignupPage(),
          // CompanyLoginPage(),
          // CompanyHomePage(),
          // CompanyProfilePage(),
          // AdminLogIn(),
          // JobDetails(),
          UserLoginPage(),
      // AdminHomePage(),
      // UserHome(),
    );
  }
}
