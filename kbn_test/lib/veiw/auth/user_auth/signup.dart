import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/user_auth/login.dart';
import 'package:kbn_test/veiw/widgets/bg_widg.dart';
import 'package:kbn_test/veiw/widgets/user_selection.dart';
import 'package:kbn_test/veiw/screen/user_screen/home.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController contactNumController = TextEditingController();
    bool _isApplicantSelected = true;


  bool _ischeck = false;
  Uint8List? _selectedImage;
  void _signin() {
    print("Full Name: ${fullNameController.text}");
    print("User Name: ${userNameController.text}");
    print("Password: ${passwordController.text}");
    print("Confirm Password: ${confirmPasswordController.text}");
    print("Contact Number: ${contactNumController.text}");
    if (_ischeck) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
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
      });
    } else {
      setState(() {
        _selectedImage = null;
      });
    };
  }
  

  @override
  void dispose() {
    userNameController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          BgWIdget(img: bg, txt: upimg),
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
                    const SizedBox(
                      height: 40,
                    ),
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
      color: logintextbox),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      SignUpUserSelectionWidget(
            appuser: "Applicant",
            isSelected: _isApplicantSelected,
            onTap: () {
              setState(() {
                _isApplicantSelected = true;
              });
            },
          ),
          SignUpUserSelectionWidget(
            appuser: "Company",
            isSelected: !_isApplicantSelected,
            onTap: () {
              setState(() {
                _isApplicantSelected = false;
              });
            },
          ),
    ],
  ),
),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Account details",
                      style: AppTextStyle.subheadertext,
                    ),
                    LoginTextForm(
                        label: "Full name",
                        controller: fullNameController),

                    LoginTextForm(
                        label: "User name",
                        controller: userNameController),
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
                    const Text(
                      tac,
                      style: AppTextStyle.tactext,
                    ),
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
                        const Text(
                          terms,
                          style: AppTextStyle.tactext,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: _ischeck ? _signin : null,
                        child: Container(
                          height: 33,
                          width: 119,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4),
                              ),
                              color: white,
                              border: Border.all(color: black),
                              gradient: LinearGradient(
                                  colors: _ischeck
                                      ? loginbutton
                                      : InnactiveLoginbutton)),
                          child: const Center(
                              child: Text(
                            signin,
                            style: AppTextStyle.signin,
                          )),
                        ),
                      ),
                    )
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
                      // Add your onTap action here
                      _selectImage();
                      // For example, you could navigate to a new page or open an image picker
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                      height: 250,
                      width: 225,
                      child: _selectedImage != null
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(_selectedImage!),
                            ) // Using Image.memory for memory image
                          : Image.asset(upimagPng),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


