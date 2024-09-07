import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kbn_test/service/apiServices.dart';
import 'dart:convert';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/company_auth/testPage.dart';
import 'package:kbn_test/veiw/widgets/error.dart';
import 'package:kbn_test/veiw/widgets/loginTextFeild.dart';
import 'package:kbn_test/veiw/widgets/bg_widg.dart';

import 'package:kbn_test/veiw/screen/companyScreen/cmpny_home.dart';



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

        if (responseData.containsKey('token') &&
            responseData.containsKey('userId')) {
          int userId = responseData['userId'];
          var token = responseData['token'];
// getting User Details
          var userDetailsResponse =
              await ApiServices.fetchUserDetails(userId, token);

          print('userData$userDetailsResponse');

          userDetails = userDetailsResponse;

          // Fetching Applicant Data
          submittedApplicantsData =
              await ApiServices.fetchSubmittedApplctns(userId, token);
          selectedApplicantsData =
              await ApiServices.fetchSelectedApplctns(userId, token);

          print('ApplicantData$submittedApplicantsData');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CompanyHomePage(),
            ),
          );
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
    return Scaffold(
      body: Stack(
        children: [
          peoplebgWIdget(img: companyBg),
          SingleChildScrollView(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: size.width * 0.5,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Image(image: AssetImage(kbnLogo)),
                    const SizedBox(height: 10),
                    const Text(firmName, style: AppTextStyle.companyName),
                    const SizedBox(height: 40),
                    const Text(welcomeComp, style: AppTextStyle.headertext),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // continue with email
                        Container(
                          height: 0.5,
                          width: 102,
                          color: black,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(useMail, style: AppTextStyle.bodytext),
                        ),
                        Container(
                          height: 0.5,
                          width: 102,
                          color: black,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    LoginTextForm(
                      controller: _emailConatroller, // Controller for username
                      label: "username",
                      hintlabel: "user_name",
                      obscure: false,
                    ),
                    LoginTextForm(
                      controller:
                          _passwordController, // Controller for password
                      label: "password",
                      hintlabel: "* * * * *",
                      obscure: true,
                      // obscureText: true,  // To obscure the password input
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ErrorPage("Forget");
                            },
                          ));
                        },
                        child: const Text(forget, style: AppTextStyle.bodytext),
                      ),
                    ),
                    const SizedBox(height: 5),
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
                        const Text(
                          "Remember me",
                          style: AppTextStyle.bodytext,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: companyLogin,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: black),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4),
                          ),
                          color: _isChecked ? black : Colors.grey,
                          gradient: LinearGradient(
                            colors:
                                _isChecked ? loginbutton : InnactiveLoginbutton,
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
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(noacc, style: AppTextStyle.bodytext),
                        TextButton(
                          onPressed: () {
                            WarningMessage(context);
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const CompanyHomePage();
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
            ),
          ),
        ],
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
