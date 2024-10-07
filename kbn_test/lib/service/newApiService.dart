// import 'dart:convert';
// import 'package:http/http.dart' as http; // Add http package to pubspec.yaml
// import 'package:kbn_test/service/modelClass.dart';

// class NewApiService {
//    static Map<String, String> headers = {
//     'Content-Type': 'application/json',
//   };
//   static const  String baseUrl = 'http://192.168.29.37:8000/company/overview2?month=9&year=2024';

//   // Function to fetch the company data
//   Future<ApiResponse> fetchCompanyData(int companyId) async {
//     try {
//       // The request body
//       Map<String, dynamic> body = {
//         "companyId": companyId,
//       };

//       // Making the POST request
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(body),
//       );

//       // Check for a successful response
//       if (response.statusCode == 200) {
//         // Parse the JSON response
//         final jsonResponse = json.decode(response.body);
//         return ApiResponse.fromJson(jsonResponse);
//       } else {
//         throw Exception("Failed to load data");
//       }
//     } catch (e) {
//       throw Exception("Error: $e");
//     }
//   }


// }
