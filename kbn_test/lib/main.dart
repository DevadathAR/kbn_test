import 'package:flutter/material.dart';
import 'package:kbn_test/veiw/auth/user_auth/UserLoginPage.dart';

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
      // UserHome()
      // JobDetails()
      UserLoginPage()
      // ColorfulContainerList()
      // RadioButtonExample()
      // MyHomePage()
      // FrogetPswd()
      // ImageSelector()
      // UploadMyResume()
      // CompanyHomePage()
      // TaCAdmin()
    );
    
  }
}
