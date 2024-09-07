import 'dart:convert';
import 'package:http/http.dart' as http;

Map<String, dynamic> userDetails = {};
Map<String, dynamic> submittedApplicantsData = {};
Map<String, dynamic> selectedApplicantsData = {};

class ApiServices {
  static const String baseUrl = 'http://192.168.29.37:8000';

  // Login API
  static Future<Map<String, dynamic>> user_login(
      String email, String password) async {
    var url = Uri.parse('$baseUrl/user/login');

    var response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'password': password,
        'loginType': "Applicant",
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<Map<String, dynamic>> company_login(
      String email, String password) async {
    var url = Uri.parse('$baseUrl/user/login');

    var response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'password': password,
        'loginType': "Company",
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed');
    }
  }

  static Future<Map<String, dynamic>> adminLogIn(
      String email, String password) async {
    var url = Uri.parse('$baseUrl/user/login');

    var response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'password': password,
        'loginType': "Admin",
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed');
    }
  }

  // Fetch User Details API
  static Future<Map<String, dynamic>> fetchUserDetails(
      int userId, String token) async {
    var url = Uri.parse('$baseUrl/user/$userId');

    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

  // Fetch submitted Applicants Data API
  static Future<Map<String, dynamic>> fetchSubmittedApplctns(
      int userId, String token) async {
    var url = Uri.parse('$baseUrl/application/c/$userId?status=submitted');

    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

  // Fetch selected Applicants Data API
  static Future<Map<String, dynamic>> fetchSelectedApplctns(
      int userId, String token) async {
    var url = Uri.parse('$baseUrl/application/c/$userId?status=selected');

    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

  // Update Application Data API
  static Future<Map<String, dynamic>> updateApplication(
    String status,
    int applicationId,
  ) async {
    var url = Uri.parse('$baseUrl/application/$applicationId');

    var response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        // Correct key-value format
        'newStatus': status
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update application');
    }
  }
}
