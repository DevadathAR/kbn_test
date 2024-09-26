import 'package:flutter/material.dart';
import 'package:kbn_test/UPDATED%20UI/Screens/statisticScreen.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:shared_preferences/shared_preferences.dart';


// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "KBN_Test",
//       debugShowCheckedModeBanner: false,
//       home: FutureBuilder(
//         future: _checkLoginStatus(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasData && snapshot.data is String) {
//             // Role-Based navigation
//             switch (snapshot.data) {
//               case 'Company':
//                 return const CompanyHomePage();
//               case 'Applicant':
//                 return const UserHome();
//               case 'Admin':
//                 return const AdminHomePage();
//               default:
//                 return const CompanyLoginPage(); // Fallback
//             }
//           } else {
//             return const CompanyLoginPage(); // Show login if no valid role
//           }
//         },
//       ),
   
//     );
//   }

//   Future<String?> _checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     String? role = prefs.getString('role'); // Retrieve the role

//     if (token == null) {
//       return null; // Not logged in
//     } else {
//       ApiServices.headers['Authorization'] = "Bearer $token";

//       var userDetailsResponse = await ApiServices.fetchUserDetails();
//       userDetails = userDetailsResponse;

//       // print(userDetailsResponse);

//       return role;
//     }
//   }
// }




// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: "KBN_Test",
//       debugShowCheckedModeBanner: false,
//       home: 
//       ScaffoldBuilder(pageName: "Transation",currentPath: "Transation",child:  CompanyJobpage(),)

      
      
//       );
//   }


// }


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "KBN_Test",
      debugShowCheckedModeBanner: false,
      
      home: StatisticScreen(),

      // StatisticScreen(),

      // Home(),

      //     FutureBuilder(
      //   future: _checkLoginStatus(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const CircularProgressIndicator();
      //     } else if (snapshot.hasData && snapshot.data is String) {
      //       // Role-Based navigation
      //       switch (snapshot.data) {
      //         case 'Company':
      //           return const CompanyHomePage();
      //         case 'Applicant':
      //           return const UserHome();
      //         case 'Admin':
      //           return const AdminHomePage();
      //         default:
      //           return const CompanyLoginPage(); // Fallback
      //       }
      //     } else {
      //       return const CompanyLoginPage(); // Show login if no valid role
      //     }
      //   },
      // ),
    );
  }

  Future<String?> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? role = prefs.getString('role'); // Retrieve the role

    if (token == null) {
      return null; // Not logged in
    } else {
      ApiServices.headers['Authorization'] = "Bearer $token";

      var userDetailsResponse = await ApiServices.fetchUserDetails();
      userDetails = userDetailsResponse;

      print(userDetailsResponse);

      return role;
    }
  }
}