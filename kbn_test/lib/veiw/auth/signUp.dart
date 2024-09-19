import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/screen/companyScreen/cmpny_home.dart';
import 'package:kbn_test/veiw/screen/userScreen/home.dart';
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
  String? _imageFilename; // Add this to store the filename

  void _signin() {
    if (_ischeck) {
      _signup();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please check the box to proceed.')),
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

  void _signup() async {
    // Get the input from the text fields
    String fullName = fullNameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String contactNumber = contactNumController.text;
    String role = roleController.text;

    // Check if the passwords match
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // Create multipart form data request
    final url = Uri.parse('http://192.168.29.37:8000/user/sign-up');
    var request = http.MultipartRequest('POST', url);

    // Add headers without Authorization
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });

    // Add the text fields to the request
    request.fields['name'] = fullName;
    request.fields['role'] = role;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['contact'] = contactNumber;

    // Add the image to the request if it exists
    if (_selectedImage != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          _selectedImage!,
          filename: _imageFilename!,
        ),
      );
    }

    // Send the request
    var response = await request.send();

    if (response.statusCode == 201) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const CompanyLoginPage(),
          // Pass the uploaded image here
        ),
      );
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
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        // width: size.width * 1 - 50,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              signup,
              style: AppTextStyle.subheadertext,
            ),
            _buildRoleSelection(constraints, isMobile: true),
            const SizedBox(height: 5),
            _buildAccountDetails(isMobile: true),
            const SizedBox(height: 5),
            _buildSignInButton(),
            const SizedBox(height: 5),
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
    );
  }

  // Method for Desktop Layout
  Widget _buildDesktopLayout(BoxConstraints constraints) {
    return Stack(
      children: [
        bgWidget(
          img: bg,
        ), // Background widget
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    style: AppTextStyle.headertext,
                  ),
                  _buildRoleSelection(constraints, isMobile: false),
                  const SizedBox(height: 15),
                  _buildAccountDetails(isMobile: false),
                  const SizedBox(height: 50),
                  _buildSignInButton(),
                ],
              ),
            ),
            _buildImagePicker(isMobile: false),
          ],
        ),
      ],
    );
  }

  // Method to build the role selection widget
  Widget _buildRoleSelection(BoxConstraints constraints,
      {required bool isMobile}) {
    return Container(
      height: 50,
      width: isMobile ? constraints.maxWidth * 0.4 : 200,
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black)],
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: logintextbox,
      ),
      child: Row(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Account details",
            style: isMobile
                ? AppTextStyle.moBsubheadertext
                : AppTextStyle.subheadertext),
        LoginTextForm(
          label: "Full name",
          controller: fullNameController,
          obscure: false,
          hight: 10,
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
        const Text(tac, style: AppTextStyle.tactext),
        const SizedBox(height: 5),
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
            const Text(terms, style: AppTextStyle.tactext),
          ],
        ),
      ],
    );
  }

  // Method to build Sign-In button
  Widget _buildSignInButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: _ischeck ? _signin : null,
        child: Container(
          height: 33,
          width: 119,
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
              style: AppTextStyle.signin,
            ),
          ),
        ),
      ),
    );
  }

  // Method to build image picker
  Widget _buildImagePicker({required bool isMobile}) {
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
              : Image.asset(upimagPng),
        ),
      ),
    );
  }
}
