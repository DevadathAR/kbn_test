import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kbn_test/service/apiServices.dart';
import 'dart:convert';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/company_auth/testPage.dart';
import 'package:kbn_test/veiw/auth/signUp.dart';
import 'package:kbn_test/veiw/widgets/error.dart';
import 'package:kbn_test/veiw/widgets/loginTextFeild.dart';
import 'package:kbn_test/veiw/widgets/bg_widg.dart';

import 'package:kbn_test/veiw/screen/companyScreen/cmpny_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> submittedApplicantsData = {};
Map<String, dynamic> selectedApplicantsData = {};
// int userId = 0;

class CompanyLoginPage extends StatefulWidget {
  const CompanyLoginPage({super.key});

  @override
  State<CompanyLoginPage> createState() => _CompanyLoginPageState();
}

class _CompanyLoginPageState extends State<CompanyLoginPage> {
  final TextEditingController _emailConatroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isChecked = true;

  @override
  void dispose() {
    _emailConatroller.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> companyLogin() async {
    if (_isChecked) {
      String email = _emailConatroller.text;
      String password = _passwordController.text;

      try {
        var responseData = await ApiServices.company_login(email, password);

        if (responseData.containsKey('token')) {
          // int userId = responseData['userId'];
          var token = responseData['token'];
          ApiServices.headers['Authorization'] = "Bearer $token";
          // getting User Details
          var userDetailsResponse = await ApiServices.fetchUserDetails();

          // print('CompanyDetails$userDetailsResponse');

          userDetails = userDetailsResponse;

          // Fetching Applicant Data
          submittedApplicantsData = await ApiServices.fetchSubmittedApplctns();
          selectedApplicantsData = await ApiServices.fetchSelectedApplctns();

          // Store login state in shared preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CompanyHomePage(),
            ),
          ); // Navigate to home page
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid username or password.')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please check the box to proceed.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    bool isMobile = size.width < 600; // Threshold for mobile view

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            peoplebgWIdget(img: companyBg),

            const Text(
              firmName,
              style: AppTextStyle.companyName,
            ),
            const SizedBox(height: 10),
            const Text(
              welcomeComp,
              style: AppTextStyle.headertext,
            ),
            const SizedBox(height: 30),

            // Continue with email section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 0.5,
                    color: black,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                const Text(
                  useMail,
                  style: AppTextStyle.bodytext,
                ),
                Expanded(
                  child: Container(
                    height: 0.5,
                    color: black,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Username and password fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  LoginTextForm(
                    controller: _emailConatroller,
                    label: "username",
                    hintlabel: "user_name",
                    obscure: false,
                  ),
                  const SizedBox(height: 15),
                  LoginTextForm(
                    controller: _passwordController,
                    label: "password",
                    hintlabel: "* * * * *",
                    obscure: true,
                  ),
                ],
              ),
            ),

            // Forget password and remember me section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        activeColor: white,
                        checkColor: black,
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                      ),
                      const Text("Remember me", style: AppTextStyle.bodytext),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ErrorPage("Forget");
                        },
                      ));
                    },
                    child: const Text(forget, style: AppTextStyle.bodytext),
                  ),
                ],
              ),
            ),

            // Login Button
            GestureDetector(
              onTap: companyLogin,
              child: Container(
                height: 50,
                width: size.width * 0.8, // Dynamic button width
                decoration: BoxDecoration(
                  border: Border.all(color: black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                  color: _isChecked ? black : Colors.grey,
                  gradient: LinearGradient(
                    colors: _isChecked ? loginbutton : InnactiveLoginbutton,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "LOGIN",
                    style: AppTextStyle.logintext,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Sign-up section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(noacc, style: AppTextStyle.bodytext),
                TextButton(
                  onPressed: () {
                    WarningMessage(context);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const SignupPage();
                      },
                    ));
                  },
                  child: const Text("SignUp"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void WarningMessage(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: semitransp,
    barrierDismissible: true, // Allows closing by tapping outside the dialog
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: none, // Transparent background
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment:
              MainAxisAlignment.center, // Ensure buttons stretch full width

          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: none,
                  border: Border.all(color: none, width: 0.5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      'If you want to start a new company,.\n'
                      'you must have approval from the admin side.',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.flitertxt),
                  const SizedBox(height: 200.0), // 20 dp space
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text(
                      'BackHome',
                      style: AppTextStyle.bodytextwhiteunderline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
