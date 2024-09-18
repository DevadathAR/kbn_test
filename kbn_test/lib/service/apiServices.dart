import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Map<String, dynamic> userDetails = {};

class ApiServices {
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  static const String baseUrl = 'http://192.168.29.37:8000';

  // Login API
  static Future<Map<String, dynamic>> user_login(
      String email, String password) async {
    var url = Uri.parse('$baseUrl/user/login');

    var response = await http.post(url,
        body: jsonEncode({
          'email': email,
          'password': password,
          'loginType': "Applicant",
        }),
        headers: headers
        // {
        //   'Content-Type': 'application/json',
        // },
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

    var response = await http.post(url,
        body: jsonEncode({
          'email': email,
          'password': password,
          // 'loginType': "Company",
        }),
        headers: headers);

    print('LpgIn Response${response.body}');

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
      }),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed');
    }
  }

  // Fetch User Details API
  static Future<Map<String, dynamic>> fetchUserDetails() async {
    var url = Uri.parse('$baseUrl/user/loggedIn');

    var response = await http.get(url, headers: headers);

    // print('userDetails${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

  // Company Section

  // Fetch submitted Applicants Data API
  static Future<Map<String, dynamic>> fetchSubmittedApplctns() async {
    var url = Uri.parse('$baseUrl/application/c/?status=submitted');

    var response = await http.get(url, headers: headers);
    // print('ApplicantData${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

  // Fetch selected Applicants Data API
  static Future<Map<String, dynamic>> fetchSelectedApplctns() async {
    var url = Uri.parse('$baseUrl/application/c/?status=selected');

    var response = await http.get(url, headers: headers);
    // print('Selected${response.body}');

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
      headers: headers,
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

  // Update AddressDetails Data API
  static Future<Map<String, dynamic>> updateAddressDetails(
    String address,
    String contact,
    String businessType,
    String website,
  ) async {
    var url = Uri.parse('$baseUrl/user/');

    var response = await http.patch(
      url,
      headers: headers,
      body: jsonEncode({
        // Correct key-value format
        'address': address,
        'contact': contact,
        'business_type': businessType,
        'company_website': website
      }),
    );
    // print('Address Updated${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update application');
    }
  }

  // Updating Vaccancy
  static Future<Map<String, dynamic>> updateVaccancy(
    String status,
    int applicationId,
  ) async {
    var url = Uri.parse('$baseUrl/application/$applicationId');

    var response = await http.patch(
      url,
      headers: headers,
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

  // View  Applicant Details API
  static Future<Map<String, dynamic>> fetchApplicantDetails(
      int applicantId) async {
    var url = Uri.parse('$baseUrl/user/$applicantId');

    var response = await http.get(url, headers: headers);

    // print('viewedApplicant${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

  static Future<http.Response> createJob(Map<String, dynamic> jobData) async {
    var url = Uri.parse('$baseUrl/job/addJob');
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(jobData),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        // Successfully created the job
        print('Job creation successful');
        // return jsonDecode(response.body);
        return response;
      } else {
        // Server responded with error
        print('Failed to create job');
        throw Exception('Failed to create job: ${response.body}');
      }
    } catch (e) {
      // Handle and log error
      print('Error occurred: $e');
      throw Exception('Error occurred while creating job: $e');
    }
  }

  /// Admin Section...........................................

// Fetch selected Applicants Data API
  static Future<Map<String, dynamic>> fetchPendingCompanie() async {
    var url = Uri.parse('$baseUrl/admin/c/pending');

    var response = await http.get(url, headers: headers);
    // print('Pending${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch pending details');
    }
  }

  // Fetch selected Applicants Data API
  static Future<Map<String, dynamic>> fetchAprovedCompanies() async {
    var url = Uri.parse('$baseUrl/admin/c/approved');

    var response = await http.get(url, headers: headers);
    // print('Approved${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch Approved CompanyList');
    }
  }

  static Future<Map<String, dynamic>> fetchCompanyDetails(int companyId) async {
    var url = Uri.parse('$baseUrl/admin/c/$companyId');

    var response = await http.get(url, headers: headers);
    // print('CompanyDetails...........${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch company details');
    }
  }

  // Updating Approval
  static Future<Map<String, dynamic>> approveCompany(
    // String status,
    int companyId,
  ) async {
    var url = Uri.parse('$baseUrl/admin/c/approve/$companyId');

    var response = await http.patch(
      url,
      headers: headers,
    );
    print(response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update application');
    }
  }

  // Updating Approval
  static Future<Map<String, dynamic>> updateAdminStatus(
      String status, int companyId) async {
    var url = Uri.parse('$baseUrl/admin/c/status/$companyId');

    var response = await http.patch(
      url,
      headers: headers,
      body: jsonEncode({
        // Correct key-value format
        'admin_status': status
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update application');
    }
  }
}
