// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:kbn_test/service/apiServices.dart';
// import 'package:kbn_test/veiw/auth/company_auth/cmpny_login.dart';

// class ApplicantPage extends StatelessWidget {
//   const ApplicantPage({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     List<dynamic> applications = submittedApplicantsData[
//         'data']; // Fetching the data list from the response

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Applicant Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
//           itemCount: applications.length, // Number of applications to display
//           itemBuilder: (context, index) {
//             var application = applications[index]; // Access each application

//             // Formatting the date
//             String formattedDate = DateFormat('yyyy-MM-dd').format(
//               DateTime.parse(application['created_at']),
//             );

//             return Card(
//               child: ListTile(
//                 title: Text('Application ID: ${application['applicationId']}'),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Date: $formattedDate'), // Display the formatted date

//                     Text('CompanyName: ${application['companyName']}'),
//                     Text('applicantName: ${application['applicantName']}'),
//                     Text('location: ${application['location']}'),
//                     Text('designation: ${application['designation']}'),
//                     Text(
//                         'Status: ${application['status']}'), // Status is now correctly treated as String
//                     Text('resumeLink: ${application['resumeLink']}'),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
