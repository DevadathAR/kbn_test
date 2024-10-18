import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/view/widgets_common/bg_widg.dart';
import 'package:http/http.dart' as http;
import 'package:kbn_test/view/widgets_common/loginTextFeild.dart';

class FrogetPswd extends StatefulWidget {
  const FrogetPswd({super.key});

  @override
  State<FrogetPswd> createState() => _FrogetPswdState();
}

class _FrogetPswdState extends State<FrogetPswd> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController contactNumController = TextEditingController();

  void _updatePassword() async {
    String newPassword = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      // Show an error message or toast if the passwords don't match
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords don't match"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Update the user's password using the API
    try {
      final response = await http.post(
        Uri.parse('http://192.168.29.37:8000/user/forgot-password'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': userNameController.text,
          'newPassword': newPassword,
          'contact': contactNumController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(updatepswd),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error updating password: ${response.statusCode}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error updating password: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _buildMobileLayout(constraints);
          } else {
            return _buildDesktopLayout(constraints);
          }
        },
      ),
    );
  }

  // Method for Mobile Layout
  Widget _buildMobileLayout(BoxConstraints constraints) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16), // Reduce padding for mobile
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: constraints.maxHeight * 0.1), // Adjust for mobile
              const Text(
                frgtpswd,
                style: AppTextStyle.twenty_w500,
              ),
              const SizedBox(height: 20),
              const Text(
                forgetpswd,
                style: AppTextStyle.bodytext_12,
              ),
              bgWidget(img: mobBg), // Responsive Background Widget

              _buildFormFields(),
              SizedBox(
                  height: constraints.maxHeight *
                      0.01), // Spacing adjustment for mobile
              _buildChangePasswordButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Method for Desktop Layout
  Widget _buildDesktopLayout(BoxConstraints constraints) {
    return Stack(
      children: [
        bgWidget(img: bg), // Responsive Background Widget
        SizedBox(
          // width: size.width * 0.5,
          width: constraints.maxWidth * 0.5,
          child: Center(
            child: SizedBox(
              width: constraints.maxWidth * 0.425,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height:
                          constraints.maxHeight * 0.25), // Adjust for desktop
                  const Text(
                    frgtpswd,
                    style: AppTextStyle.thirty_w500,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    forgetpswd,
                    style: AppTextStyle.bodytext_12,
                  ),
                  _buildFormFields(),
                  SizedBox(
                      height: constraints.maxHeight *
                          0.1), // Spacing adjustment for desktop
                  _buildChangePasswordButton(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Method for form fields
  Widget _buildFormFields() {
    return Column(
      children: [
        LoginTextForm(label: "User name", controller: userNameController),
        LoginTextForm(
          label: "Create Password",
          obscure: true,
          controller: passwordController,
        ),
        LoginTextForm(
          label: "Confirm Password",
          obscure: true,
          controller: confirmPasswordController,
        ),
        LoginTextForm(
          label: "Contact Number",
          controller: contactNumController,
        ),
      ],
    );
  }

  // Method for Change Password button
  Widget _buildChangePasswordButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: _updatePassword,
        child: Container(
          height: 33,
          width: 119,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: Colors.white,
            border: Border.all(color: Colors.black),
            gradient: const LinearGradient(colors: loginbutton),
          ),
          child: const Center(
            child: Text(
              "Change",
              style: AppTextStyle.fifteenW500,
            ),
          ),
        ),
      ),
    );
  }
}
