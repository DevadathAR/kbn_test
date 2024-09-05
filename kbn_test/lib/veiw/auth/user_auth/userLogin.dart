import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/forgotPass.dart';
import 'package:kbn_test/veiw/auth/signUp.dart';
import 'package:kbn_test/veiw/screen/userScreen/home.dart';
import 'package:kbn_test/veiw/widgets/bg_widg.dart';
import 'package:kbn_test/veiw/widgets/loginTextFeild.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isChecked = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // if (!_isChecked||_isChecked) {
    // String username = _usernameController.text;
    // String password = _passwordController.text;

    try {
      var url = Uri.parse('http://192.168.29.37:8000/user/login');

      var response = await http.post(
        url,
        body: jsonEncode({
          'email': usernameController.text,
          'password': passwordController.text,
          'loginType': "Applicant",
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      // Check if the login was successful
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData is Map && responseData.containsKey('token')) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UserHome(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid username or password.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          BgWIdget(img: loginbg),
          SingleChildScrollView(
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
                  const Text(welcome, style: AppTextStyle.headertext),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                    controller: usernameController, // Controller for username
                    label: "email",
                  ),
                  LoginTextForm(
                    obscure: true,
                    controller: passwordController, // Controller for password
                    label: "password",
                    hintlabel: "* * * * *",
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
                    onTap: _login,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: black),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                        color: _isChecked ? black : Colors.grey,
                        gradient: const LinearGradient(
                          colors: loginbutton,
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
      ),
    );
  }
}
