import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/widgets_common/bg_widg.dart';
import 'package:kbn_test/veiw/widgets_common/loginTextFeild.dart';
import 'package:kbn_test/veiw/screen/userScreen/userWidgets/userSelection.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController contactNumController = TextEditingController();
  bool _isApplicantSelected = true;
  bool _ischeck = false;
  Uint8List? _selectedImage;
  String? _imageFilename;
  final ApiServices _apiService = ApiServices(); // Instantiate the ApiService

  void _signin() {
    if (_ischeck) {
      _signup();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please check the box to proceed.')),
      );
    }
  }

  Future<void> _signup() async {
    String fullName = fullNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String contactNumber = contactNumController.text.trim();
    String role = roleController.text.trim();

    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        contactNumber.isEmpty ||
        role.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all the fields')),
      );
      return;
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      // Call the ApiService signUp method
      var response = await _apiService.signUp(
        fullName: fullName,
        email: email,
        password: password,
        contactNumber: contactNumber,
        role: role,
        selectedImage: _selectedImage,
        imageFilename: _imageFilename,
      );

      if (response.statusCode == 201) {
        // Successful signup
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Sign up successful! Redirecting to login...')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CompanyLoginPage(),
          ),
        );
      } else {
        // Handle unsuccessful signup
        final errorMessage = await response.stream.bytesToString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up failed: $errorMessage')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _selectedImage = bytes;
        _imageFilename = pickedFile.name; // Store the filename
      });
    } else {
      setState(() {
        _selectedImage = null;
        _imageFilename = null; // Clear the filename
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    roleController.dispose();
    contactNumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return _buildMobileLayout(constraints);
            } else {
              return _buildDesktopLayout(constraints);
            }
          },
        ),
      ),
    );
  }

  // Method for Mobile Layout
  Widget _buildMobileLayout(BoxConstraints constraints) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width < 130 ? 5 : 35.0, vertical: 5),
          child: Container(
            // width: size.width * 1 - 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  signup,
                  style: AppTextStyle.twenty_w500,
                ),
                _buildRoleSelection(constraints, isMobile: true),
                const SizedBox(height: 10),
                _buildAccountDetails(isMobile: true),
                const SizedBox(height: 10),
                _buildSignInButton(),
                const SizedBox(height: 10),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    bgWidget(
                      img: mobileBg,
                    ), // Background widget
                    _buildImagePicker(isMobile: true),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method for Desktop Layout
  Widget _buildDesktopLayout(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: constraints.maxWidth * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                signup,
                style: AppTextStyle.thirty_w500,
              ),
              _buildRoleSelection(constraints, isMobile: false),
              const SizedBox(height: 15),
              _buildAccountDetails(isMobile: false),
              const SizedBox(height: 50),
              _buildSignInButton(),
            ],
          ),
        ),
        Expanded  (
          child: Stack(
            alignment: Alignment.center,
            children: [
              bgWidget(
                img: bg,
              ),
              _buildImagePicker(isMobile: false),
            ],
          ),
        )
      ],
    );
  }

  // Method to build the role selection widget
  Widget _buildRoleSelection(BoxConstraints constraints,
      {required bool isMobile}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 50,
      width: size.width < 600
          ? size.width < 300
              ? size.width * 0.9
              : size.width * 0.6
          : 400,
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black)],
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: logintextbox,
      ),
      child:
          // if needed covert into colum for below 200 pixel
          //   size.width<200?
          //   Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       SignUpUserSelectionWidget(
          //         appuser: "Applicant",
          //         isSelected: _isApplicantSelected,
          //         onTap: () {
          //           setState(() {
          //             _isApplicantSelected = true;
          //             roleController.text = "Applicant";
          //           });
          //         },
          //       ),
          //       SignUpUserSelectionWidget(
          //         appuser: "Company",
          //         isSelected: !_isApplicantSelected,
          //         onTap: () {
          //           setState(() {
          //             _isApplicantSelected = false;
          //             roleController.text = "Company";
          //           });
          //         },
          //       ),
          //     ],
          //   )
          // :

          Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SignUpUserSelectionWidget(
            appuser: "Applicant",
            isSelected: _isApplicantSelected,
            onTap: () {
              setState(() {
                _isApplicantSelected = true;
                roleController.text = "Applicant";
              });
            },
          ),
          SignUpUserSelectionWidget(
            appuser: "Company",
            isSelected: !_isApplicantSelected,
            onTap: () {
              setState(() {
                _isApplicantSelected = false;
                roleController.text = "Company";
              });
            },
          ),
        ],
      ),
    );
  }

  // Method to build account details form
  Widget _buildAccountDetails({required bool isMobile}) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Account details",
            style:
                isMobile ? AppTextStyle.twenty_w500 : AppTextStyle.twenty_w500),
        LoginTextForm(
          label: "Full name",
          controller: fullNameController,
          obscure: false,
          hight: 10,
          // width: size.width<1500?1500-(size.width):null
        ),
        LoginTextForm(
          label: "Email",
          controller: emailController,
          hight: 10,
          obscure: false,
        ),
        LoginTextForm(
          obscure: true,
          label: "Create Password",
          hight: 10,
          controller: passwordController,
        ),
        LoginTextForm(
          obscure: true,
          label: "Confirm Password",
          controller: confirmPasswordController,
          hight: 10,
        ),
        LoginTextForm(
          label: "Contact Number",
          controller: contactNumController,
          obscure: false,
          hight: 10,
        ),
        const Text(tac, style: AppTextStyle.fourteenW400),
        const SizedBox(height: 5),
        if (size.width > 210)
          Row(
            children: [
              Checkbox(
                activeColor: Colors.white,
                checkColor: Colors.black,
                value: _ischeck,
                onChanged: (bool? value) {
                  setState(() {
                    _ischeck = value ?? false;
                  });
                },
              ),
              SizedBox(
                  width: size.width < 341 ? size.width * 1 - 128 : null,
                  child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(terms, style: AppTextStyle.fourteenW400)))
            ],
          )
        else
          Column(
            children: [
              Checkbox(
                activeColor: Colors.white,
                checkColor: Colors.black,
                value: _ischeck,
                onChanged: (bool? value) {
                  setState(() {
                    _ischeck = value ?? false;
                  });
                },
              ),
              const Text(terms, style: AppTextStyle.smallText),
            ],
          )
      ],
    );
  }

  // Method to build Sign-In button
  Widget _buildSignInButton() {
    Size size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: _ischeck ? _signin : null,
        child: Container(
          height: 33,
          width: size.width < 341 ? null : 119,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: Colors.white,
            border: Border.all(color: Colors.black),
            gradient: LinearGradient(
              colors: _ischeck ? loginbutton : InnactiveLoginbutton,
            ),
          ),
          child: const Center(
            child: Text(
              signin,
              style: AppTextStyle.fifteenW500,
            ),
          ),
        ),
      ),
    );
  }

  // Method to build image picker
  Widget _buildImagePicker({required bool isMobile}) {
    Size size = MediaQuery.of(context).size;

    return Align(
      alignment: isMobile ? Alignment.center : Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          _selectImage();
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: isMobile ? 150 : 250,
          width: isMobile ? 150 : 225,
          child: _selectedImage != null
              ? CircleAvatar(
                  backgroundImage: MemoryImage(_selectedImage!),
                )
              : Image.asset(
                  upimagPng,
                  scale: size.width < 600
                      ? size.width < 350
                          ? size.width < 200
                              ? 15
                              : 8
                          : 5
                      : 1,
                ),
        ),
      ),
    );
  }
}
