import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/company_auth/cmpny_login.dart';
import 'package:kbn_test/veiw/auth/user_auth/userLogin.dart';
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
      body: Stack(
        children: [
          BgWIdget(img: bg),
          SizedBox(
            height: size.height * 1,
            width: size.width * 0.5,
            child: Center(
              child: SizedBox(
                height: size.height * 1,
                width: size.width * 0.425,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          signup,
                          style: AppTextStyle.headertext,
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      decoration: const BoxDecoration(
                        boxShadow: [BoxShadow(color: black)],
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
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Account details",
                      style: AppTextStyle.subheadertext,
                    ),
                    LoginTextForm(
                        label: "Full name", controller: fullNameController),
                    LoginTextForm(label: "email", controller: emailController),
                    LoginTextForm(
                        obscure: true,
                        label: "Create Password",
                        controller: passwordController),
                    LoginTextForm(
                        label: "Confirm Password",
                        obscure: true,
                        controller: confirmPasswordController),
                    LoginTextForm(
                        label: "Contact Number",
                        controller: contactNumController),
                    const Text(tac, style: AppTextStyle.tactext),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: white,
                          checkColor: black,
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
                    const SizedBox(height: 50),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: _ischeck ? _signin : null,
                        child: Container(
                          height: 33,
                          width: 119,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            color: white,
                            border: Border.all(color: black),
                            gradient: LinearGradient(
                              colors:
                                  _ischeck ? loginbutton : InnactiveLoginbutton,
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
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 200),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 180),
                    child: SizedBox(height: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectImage();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      height: 250,
                      width: 225,
                      child: _selectedImage != null
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(_selectedImage!),
                            )
                          : Image.asset(upimagPng),
                    ),
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
