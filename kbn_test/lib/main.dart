import 'package:flutter/material.dart';
import 'package:kbn_test/veiw/auth/user_auth/forgetpswd.dart';
import 'package:kbn_test/veiw/auth/user_auth/login.dart';
import 'package:kbn_test/veiw/screen/company_screen/cmony_home.dart';
import 'package:kbn_test/veiw/screen/user_screen/home.dart';
import 'package:kbn_test/veiw/screen/user_screen/jobdetails.dart';
import 'package:kbn_test/veiw/widgets/check.dart';
import 'package:kbn_test/veiw/widgets/upload_resume.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return  const MaterialApp(
      title: "KBN_Test",
      debugShowCheckedModeBanner: false,
      home:
      // ApplicantCompanyToggleButton()
      // Home()
      // JobDetails()
      // LogInPage()
      // RadioButtonExample()
      // MyHomePage()
      // FrogetPswd()
      // ImageSelector()
      // UploadMyResume()
      CompanyHomePage()
    );
  }
}
