// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Map<String, dynamic> userDetails = {};
// Map<String, dynamic> jobDetailsResponse = {};
// List<dynamic> jobs = [];

// class ApiServices {
//   static const String baseUrl = 'http://192.168.29.37:8000';
//   // static const String baseUrl2 = 'http://192.168.29.37:8000';
//   static const String baseUrl2 = 'http://192.168.29.197:5500';

//   // Login API
//   static Future<Map<String, dynamic>> user_login(
//       String email, String password) async {
//     var url = Uri.parse('$baseUrl/user/login');

//     var response = await http.post(
//       url,
//       body: jsonEncode({
//         'email': "john123@gmail.com",
//         'password': "john@123",
//         // 'email': email,
//         // 'password': password,
//         'loginType': "Applicant",
//       }),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to login');
//     }
//   }

//   // Company login API
//   static Future<Map<String, dynamic>> company_login(
//       String email, String password) async {
//     var url = Uri.parse('$baseUrl/user/login');

//     var response = await http.post(
//       url,
//       body: jsonEncode({
//         'email': email,
//         'password': password,
//         'loginType': "Company",
//       }),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Login failed');
//     }
//   }

//   // Fetch User Details API
//   static Future<Map<String, dynamic>> fetchUserDetails(
//       int userId, String token) async {
//     var url = Uri.parse('$baseUrl/user/$userId');

//     var response = await http.get(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );
//     // print(response);

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to fetch user details');
//     }
//   }

//   // Fetch Job Titles API
//   static Future<List<dynamic>> fetchJobTitles() async {
//     try {
//       var url = Uri.parse('$baseUrl2/job');
//       var response = await http.get(url);

//       if (response.statusCode == 200) {
//         var jsonData = jsonDecode(response.body);
//         // print(jsonData);
//         var data = jsonData['data'];

//         if (data is List) {
//           return data;
//         } else {
//           print('Unexpected structure: "data" is not a list');
//           return [];
//         }
//       } else {
//         print('Failed to load job titles');
//         return [];
//       }
//     } catch (error) {
//       print('Error: $error');
//       return [];
//     }
//   }

//   // Post Job Details API - post jobId as param and companyId in the body
//   static Future<void> postJobDetails(
//     int jobId,
//     int companyId,
//   ) async {
//     // Construct the URL with the dynamic jobId
//     var url = Uri.parse('$baseUrl2/job/$jobId');

//     try {
//       var response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization':
//               'Bearer ${userDetails['token']}', // Ensure token is set
//         },
//         body: jsonEncode({
//           'companyId': companyId, // Send companyId in the request body
//         }),
//       );

//       if (response.statusCode == 200) {
//         var jsonData = jsonDecode(response.body);
//         jobDetailsResponse = jsonDecode(response.body);

//         // print(jsonData);
//         print(jobDetailsResponse);

//         print("Job details posted successfully.");
//       } else {
//         print("Failed to post job details: ${response.statusCode}");
//       }
//     } catch (error) {
//       print("Error posting job details: $error");
//     }
//   }

//   static Future<Map<String, dynamic>> applyForJob(int jobId, int userId) async {
//     final url = Uri.parse('$baseUrl2/application/create'); // Update to your API endpoint

//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'jobId': jobId, 'userId': userId}),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to apply for job');
//     }
//   }
  
// }