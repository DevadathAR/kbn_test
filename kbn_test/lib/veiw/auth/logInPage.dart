import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/singletonData.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/forgotPass.dart';
import 'package:kbn_test/veiw/auth/signUp.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/companyHome.dart';
import 'package:kbn_test/veiw/screen/userScreen/home.dart';
import 'package:kbn_test/veiw/widgets_common/loginTextFeild.dart';
import 'package:kbn_test/veiw/widgets_common/bg_widg.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isCompany = false;

class CompanyLoginPage extends StatefulWidget {
  const CompanyLoginPage({super.key});

  @override
  State<CompanyLoginPage> createState() => _CompanyLoginPageState();
}

class _CompanyLoginPageState extends State<CompanyLoginPage> {
  final TextEditingController _emailConatroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isChecked = false;

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
        var responseData = await ApiServices.userLogin(email, password);

        if (responseData.containsKey('token') &&
            responseData.containsKey('role')) {
          var token = responseData['token'];
          var role = responseData['role'];

          if (role != 'Admin') {
            isCompany = true;
          } else {
            isCompany = false;
          }
          // ApiDataService().isCompany = role == 'Company';

          var userDetailsResponse = await ApiServices.fetchUserDetails();
          userDetails = userDetailsResponse;

          // Store login state in shared preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await prefs.setString('role', role); // Save the role

          if (role == 'Company') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CompanyHome(),
              ),
            );
          } else if (role == 'Admin') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CompanyHome(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const UserHome(),
              ),
            );
          }
          // Navigate to home page
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          bool isMobile = screenWidth < 600; // Define mobile threshold

          return Align(
            alignment: Alignment.centerRight,
            child: isMobile
                ? _buildMobileLayout(context)
                : _buildWebLayout(context, screenWidth),
          );
        },
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context, double screenWidth) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        peoplebgWIdget(img: companyBg),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: screenWidth * 0.4,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Image(image: AssetImage(kbnLogo)),
                const SizedBox(height: 10),
                const Text(firmName, style: AppTextStyle.twntyFive_W600),
                const SizedBox(height: 40),
                const Text("Welcome Back", style: AppTextStyle.thirty_w500),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 0.5, width: size.width * 0.05, color: black),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(useMail, style: AppTextStyle.bodytext_12),
                    ),
                    Container(
                        height: 0.5, width: size.width * 0.05, color: black),
                  ],
                ),
                const SizedBox(height: 30),
                LoginTextForm(
                  controller: _emailConatroller,
                  label: "username",
                  hintlabel: "user_name",
                  obscure: false,
                ),
                LoginTextForm(
                  controller: _passwordController,
                  label: "password",
                  hintlabel: "* * * * *",
                  obscure: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const FrogetPswd();
                        },
                      ));
                    },
                    child: const Text(forget, style: AppTextStyle.bodytext_12),
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
                    const Text("Remember me", style: AppTextStyle.bodytext_12),
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
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: _isChecked ? black : Colors.grey,
                      gradient: LinearGradient(
                        colors: _isChecked ? loginbutton : InnactiveLoginbutton,
                      ),
                    ),
                    child: const Center(
                      child: Text("LOGIN", style: AppTextStyle.logintext),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(noacc, style: AppTextStyle.bodytext_12),
                    TextButton(
                      onPressed: () {
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
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Image(image: AssetImage(kbnLogo)),
            const SizedBox(height: 10),
            const Text(firmName, style: AppTextStyle.eighteen_W600),
            Stack(
              alignment: Alignment.center,
              children: [
                peoplebgWIdget(img: mobCompanyBg),
                const Positioned(
                    bottom: 5,
                    child: Text("Welcome Back",
                        style: AppTextStyle.twntyFive_W600)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 0.5, width: 102, color: black),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(useMail, style: AppTextStyle.bodytext_12),
                ),
                Container(height: 0.5, width: 102, color: black),
              ],
            ),
            const SizedBox(height: 10),
            LoginTextForm(
              controller: _emailConatroller,
              label: "username",
              hintlabel: "user_name",
              obscure: false,
              hight: 20,
            ),
            LoginTextForm(
              controller: _passwordController,
              label: "password",
              hintlabel: "* * * * *",
              obscure: true,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const FrogetPswd();
                    },
                  ));
                },
                child: const Text(forget, style: AppTextStyle.bodytext_12),
              ),
            ),
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
                const Text("Remember me", style: AppTextStyle.bodytext_12),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: companyLogin,
              child: Container(
                height: 50,
                width: size.width * 1 - 100,
                decoration: BoxDecoration(
                  border: Border.all(color: black),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: _isChecked ? black : Colors.grey,
                  gradient: LinearGradient(
                    colors: _isChecked ? loginbutton : InnactiveLoginbutton,
                  ),
                ),
                child: const Center(
                  child: Text("LOGIN", style: AppTextStyle.logintext),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(noacc, style: AppTextStyle.bodytext_12),
                TextButton(
                  onPressed: () {
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

void approvalWarning(BuildContext context) {
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
                      'If you are new here,you must have.\n'
                      'approval for your company from the admin side.',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.sixteen_w400_white),
                  const SizedBox(height: 200.0), // 20 dp space
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text(
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
