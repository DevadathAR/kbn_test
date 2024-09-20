// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:kbn_test/service/apiServices.dart';
// import 'dart:convert';
// import 'package:kbn_test/utilities/assets_path.dart';
// import 'package:kbn_test/utilities/colors.dart';
// import 'package:kbn_test/utilities/const.dart';
// import 'package:kbn_test/utilities/text_style.dart';
// import 'package:kbn_test/veiw/auth/company_auth/cmpny_login.dart';
// import 'package:kbn_test/veiw/auth/forgotPass.dart';
// import 'package:kbn_test/veiw/screen/AdminScreen/adminHome.dart';
// import 'package:kbn_test/veiw/widgets/loginTextFeild.dart';
// import 'package:kbn_test/veiw/widgets/bg_widg.dart';

// import 'package:kbn_test/veiw/screen/companyScreen/cmpny_home.dart';
// import 'package:kbn_test/veiw/screen/userScreen/home.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AdminLogIn extends StatefulWidget {
//   const AdminLogIn({super.key});

//   @override
//   State<AdminLogIn> createState() => _AdminLogInState();
// }

// class _AdminLogInState extends State<AdminLogIn> {
//   final TextEditingController _emailConatroller = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   bool _isChecked = true;

//   @override
//   void dispose() {
//     _emailConatroller.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> adminLogin() async {
//     if (_isChecked) {
//       // String email = _emailConatroller.text;
//       // String password = _passwordController.text;
//       String email = "admin";
//       String password = "admin@123";

//       try {
//         var responseData = await ApiServices.adminLogIn(email, password);

//         if (responseData.containsKey('token')) {
//           var token = responseData['token'];
//           ApiServices.headers['Authorization'] = "Bearer $token";

//           print("Token$token");

//           var userDetailsResponse = await ApiServices.fetchUserDetails();
//           // print("Admin Details$userDetailsResponse");

//           userDetails = userDetailsResponse;

//           // Store login state in shared preferences
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           await prefs.setString('token', token);

//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const AdminHomePage(),
//             ),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Invalid username or password.')),
//           );
//         }
//       } catch (error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: $error')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please check the box to proceed.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           peoplebgWIdget(img: companyBg),
//           SingleChildScrollView(
//             child: Align(
//               alignment: Alignment.centerRight,
//               child: Container(
//                 width: size.width * 0.4,
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 20),
//                     const Image(image: AssetImage(kbnLogo)),
//                     const SizedBox(height: 10),
//                     const Text(firmName, style: AppTextStyle.companyName),
//                     const SizedBox(height: 40),
//                     const Text("welcome Admin", style: AppTextStyle.headertext),
//                     const SizedBox(height: 30),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // continue with email
//                         Container(
//                           height: 0.5,
//                           width: 102,
//                           color: black,
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 5),
//                           child: Text(useMail, style: AppTextStyle.bodytext),
//                         ),
//                         Container(
//                           height: 0.5,
//                           width: 102,
//                           color: black,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 30),
//                     LoginTextForm(
//                       controller: _emailConatroller, // Controller for username
//                       label: "username",
//                       hintlabel: "user_name",
//                       obscure: false,
//                     ),
//                     LoginTextForm(
//                       controller:
//                           _passwordController, // Controller for password
//                       label: "password",
//                       hintlabel: "* * * * *",
//                       obscure: true,
//                       // obscureText: true,  // To obscure the password input
//                     ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(
//                             builder: (context) {
//                               return FrogetPswd();
//                             },
//                           ));
//                         },
//                         child: const Text(forget, style: AppTextStyle.bodytext),
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Row(
//                       children: [
//                         Checkbox(
//                           activeColor: white,
//                           checkColor: black,
//                           value: _isChecked,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               _isChecked = value ?? false;
//                             });
//                           },
//                         ),
//                         const Text(
//                           "Remember me",
//                           style: AppTextStyle.bodytext,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     GestureDetector(
//                       onTap: adminLogin,
//                       child: Container(
//                         height: 50,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: black),
//                           borderRadius: const BorderRadius.all(
//                             Radius.circular(4),
//                           ),
//                           color: _isChecked ? black : Colors.grey,
//                           gradient: LinearGradient(
//                             colors:
//                                 _isChecked ? loginbutton : InnactiveLoginbutton,
//                           ),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             "LOGIN",
//                             style: AppTextStyle.logintext,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(noacc, style: AppTextStyle.bodytext),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(context, MaterialPageRoute(
//                               builder: (context) {
//                                 return const UserHome();
//                               },
//                             ));
//                           },
//                           child: const Text("SignUp"),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
