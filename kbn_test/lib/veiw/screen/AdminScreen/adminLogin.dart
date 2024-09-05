import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/AdminScreen/adminHome.dart';
import 'package:kbn_test/veiw/widgets/error.dart';
import 'package:kbn_test/veiw/widgets/loginTextFeild.dart';
import 'package:kbn_test/veiw/widgets/bg_widg.dart';

import 'package:kbn_test/veiw/screen/companyScreen/cmpny_home.dart';
import 'package:kbn_test/veiw/screen/userScreen/home.dart';

class AdminLogIn extends StatefulWidget {
  const AdminLogIn({super.key});

  @override
  State<AdminLogIn> createState() => _AdminLogInState();
}

class _AdminLogInState extends State<AdminLogIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isChecked = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> Admin_login() async {
    if (_isChecked) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      try {
        var url = Uri.parse('http://192.168.29.37:8000/user/login');

        var response = await http.post(
          url,
          body: jsonEncode({
            // 'username': username,
            // 'password': password,
            'email': "john123@gmail.com",
            'password': "john@123",
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
                builder: (context) => const AdminHomePage(),
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
                    const Text(welcome, style: AppTextStyle.headertext),
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
                      controller:
                          _usernameController, // Controller for username
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
                      onTap: Admin_login,
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
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const UserHome();
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
