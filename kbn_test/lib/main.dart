import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/companyHome.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/screen/userScreen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "KBN_Test",
      debugShowCheckedModeBanner: false,
      home:
          //  CompanyStatisticScreen(),
          // TermsNconditions(),
          // CompanyHome()

          // AdminHome(),

          //  CompanyJobpage(),

          // Home(),

          FutureBuilder(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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

      // print(userDetailsResponse);

      return role;
    }
  }
}
