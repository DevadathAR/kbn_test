import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Map<String, dynamic> userDetails = {};
Map<String, dynamic> jobDetailsResponse = {};
List<dynamic> jobs = [];

class ApiServices {
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  // static const String baseUrl = 'http://192.168.29.37:8000';
  static const String baseUrl = 'http://192.168.29.197:5500';

  // Login API
  static Future<Map<String, dynamic>> userLogin(
      String email, String password) async {
    var url = Uri.parse('$baseUrl/user/login');
    // print(url);
    var response = await http.post(
      url,
      body: jsonEncode({
        // 'email': "company2@gmail.com",
        // 'password': "123",
        // 'email': "applicant8@gmail.com",
        // 'password': "123",
        'email': email,
        'password': password,
        // 'loginType': "Applicant",
      }),
      headers: {'Content-Type': 'application/json'},
    );

    // print("Login response: ${response.statusCode}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var token = data['token']; // Save the token for future requests
      headers['Authorization'] = 'Bearer $token';

      return data;
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  // static Future<Map<String, dynamic>> company_login(
  //     String email, String password) async {
  //   var url = Uri.parse('$baseUrl/user/login');

  //   var response = await http.post(url,
  //       body: jsonEncode({
  //         'email': email,
  //         'password': password,
  //         // 'loginType': "Company",
  //       }),
  //       headers: headers);

  //   print('LpgIn Response${response.body}');

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Login failed');
  //   }
  // }

  // Fetch User Details API
  static Future<Map<String, dynamic>> fetchUserDetails() async {
    var url = Uri.parse('$baseUrl/user/loggedIn');

    var response = await http.get(url, headers: headers);

    print('userDetails${response.body}');

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

  //..............................................................

  static Future<Map<String, List<String>>> fetchDropdownBoxItems() async {
    final url = Uri.parse('$baseUrl/job/dropbox');

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // print('Response status: ${response.statusCode}');
      print('DropBox: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final dropBox = data['dropBox'];
        // print(data);
        // print(dropBox);

        if (dropBox == null) {
          throw Exception('Invalid response format');
        }

        return {
          'jobTypes': List<String>.from(dropBox['jobType'] ?? []),
          'experiences': List<String>.from(dropBox['experience'] ?? []),
          'locations': List<String>.from(dropBox['location'] ?? []),
          'workModes': List<String>.from(dropBox['workMode'] ?? []),
        };
      } else {
        throw Exception("Failed to fetch dropdown box items");
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  static Future<void> uploadResume(Uint8List fileBytes, String fileName) async {
    final uri = Uri.parse('$baseUrl/user/resume');
    final request = http.MultipartRequest('POST', uri);

    request.files.add(http.MultipartFile.fromBytes(
      'resume',
      fileBytes,
      filename: fileName,
    ));

    // Add headers (including Authorization)
    request.headers.addAll(headers);

    // Send the request
    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to upload file with status: ${response.statusCode}');
    }
  }

  // Fetch Job Titles API

  // Post Job Details API
  static Future<void> postJobDetails(int jobId) async {
    var url = Uri.parse('$baseUrl/job/$jobId');

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({'companyId': jobId}),
    );

    if (response.statusCode == 200) {
      print("Job details posted successfully.");
    } else {
      throw Exception('Failed to post job details: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> applyForJob(int jobId) async {
    final url = Uri.parse('$baseUrl/application/create');

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        'jobId': jobId,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to apply for job: ${response.body}');
    }
  }

  static Future<List<dynamic>> fetchJobTitles() async {
    var url = Uri.parse('$baseUrl/job/filter');

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // log(jsonEncode(data));
      return data['data'] as List;
    } else {
      throw Exception('Failed to fetch job titles');
    }
  }

  // Fetch Filtered Jobs
  static Future<Map<String, dynamic>> fetchFilteredJobs({
    String? selectedJobType,
    String? selectedSalary,
    String? selectedExperience,
    String? selectedWorkMode,
    String? selectedLocation,
    int? pageNumber,
    int pageSize = 8,
  }) async {
    int? minSalary;
    int? maxSalary;

    if (selectedSalary != null && selectedSalary != "Salary") {
      List<String> salaryParts = selectedSalary.split('-');
      if (salaryParts.length == 2) {
        minSalary = int.tryParse(salaryParts[0]);
        maxSalary = int.tryParse(salaryParts[1]);
      }
    }

    final queryParameters = {
      if (selectedJobType != null && selectedJobType != "Job Type")
        'jobType': selectedJobType,
      if (selectedExperience != null && selectedExperience != "Experience")
        'experienceLevel': selectedExperience,
      if (selectedWorkMode != null && selectedWorkMode != "Work Mode")
        'workMode': selectedWorkMode,
      if (selectedLocation != null && selectedLocation != "Location")
        'location': selectedLocation,
      if (minSalary != null) 'minSalary': minSalary.toString(),
      if (maxSalary != null) 'maxSalary': maxSalary.toString(),
      if (pageNumber != null) 'page': pageNumber.toString(),
    };

    final uri = Uri.parse('$baseUrl/job/filter')
        .replace(queryParameters: queryParameters);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final totalJobs = data["totalJobs"];
      log(jsonEncode(data));

      return {
        'data': data['data'] as List,
        'totalJobs': totalJobs,
      };
    } else {
      throw Exception("Failed to fetch filtered jobs");
    }
  }
}
