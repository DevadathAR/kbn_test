import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:kbn_test/service/adminMode.dart';
import 'package:kbn_test/service/companymodelClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> userDetails = {};
Map<String, dynamic> jobDetailsResponse = {};
List<dynamic> jobs = [];

class ApiServices {
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    // "ngrok-skip-browser-warning": "69420"
  };
  static const String baseUrl = 'http://192.168.29.77:8000';
  // static const String baseUrl =
  //     'https://acab-2405-201-f017-980d-fd96-e1c9-8e85-ce21.ngrok-free.app';

  Future<http.StreamedResponse> signUp({
    required String fullName,
    required String email,
    required String password,
    required String contactNumber,
    required String role,
    Uint8List? selectedImage,
    String? imageFilename,
  }) async {
    final url = Uri.parse('$baseUrl/user/sign-up');

    // Create multipart form data request
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
    if (selectedImage != null && imageFilename != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          selectedImage,
          filename: imageFilename,
        ),
      );
    }

    // Send the request and return the response
    return await request.send();
  }

  // Login API
  static Future<Map<String, dynamic>> userLogin(
      String email, String password) async {
    var url = Uri.parse('$baseUrl/user/login');
    // print(url);
    var response = await http.post(
      url,
      body: jsonEncode({
        // 'email': "festa",
        // 'password': "123",
        // 'email': "applicant8@gmail.com",
        // 'password': "123",
        'email': email,
        'password': password,
      }),
      headers: headers,
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

  // Company/Admin Section
//.........................................
  // static Future<CompanyApiResponse> companyData() async {
  //   var url = Uri.parse('$baseUrl/company/data?month=10&year=2024');

  //   var response = await http.get(url, headers: headers);

  //   // print('Raw response: ${response.body}');

  //   if (response.statusCode == 200) {
  //     // Decode the JSON response
  //     var jsonMap = jsonDecode(response.body);
  //     // Return an ApiResponse object
  //     return CompanyApiResponse.fromJson(jsonMap);
  //   } else {
  //     throw Exception('Failed to fetch user details');
  //   }
  // }

//   static Future<CompanyApiResponse> companyData({required DateTime selectedDate}) async {
//   int month = selectedDate.month;
//   int year = selectedDate.year;

//   var url = Uri.parse('$baseUrl/company/data?month=$month&year=$year');

//   var response = await http.get(url, headers: headers);

//   if (response.statusCode == 200) {
//     var jsonMap = jsonDecode(response.body);
//     return CompanyApiResponse.fromJson(jsonMap);
//   } else {
//     throw Exception('Failed to fetch user details');
//   }
// }
  static Future<CompanyApiResponse?> companyData() async {
    var prefs = await SharedPreferences.getInstance();
    int month = prefs.getInt('selectedMonth') ?? DateTime.now().month;
    int year = prefs.getInt('selectedYear') ?? DateTime.now().year;

    var url = Uri.parse('$baseUrl/company/data?month=$month&year=$year');

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonMap = jsonDecode(response.body);
      log("url ${response.statusCode}");
      // log("company ${response.body}");
      // try {
        return CompanyApiResponse.fromJson(jsonMap);
      // } catch (e) {
      //   print(e);
      //   // return null;
      // }
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

  static Future<AdminApiResponse> adminData() async {
     var prefs = await SharedPreferences.getInstance();
    int month = prefs.getInt('selectedMonth') ?? DateTime.now().month;
    int year = prefs.getInt('selectedYear') ?? DateTime.now().year;
    var url = Uri.parse('$baseUrl/admin/data?month=$month&year=$year');

    var response = await http.get(url, headers: headers);

          //  log("company ${response.body}");


    // print('Raw response: ${response.body}');

    if (response.statusCode == 200) {
      // Decode the JSON response
      var jsonMap = jsonDecode(response.body);
      // Return an ApiResponse object
      return AdminApiResponse.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

  // View  Applicant Details API
  static Future<Map<String, dynamic>> fetchApplicantDetails(int userId) async {
    var url = Uri.parse('$baseUrl/user/$userId');

    var response = await http.get(url, headers: headers);

    // print('viewedApplicant${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

//.........................................................................
// PATCH REQUESTS
// Update Job Status API
  static Future<Map<String, dynamic>> updateJobStatus(
    String status,
    int applicationId,
  ) async {
    var url = Uri.parse('$baseUrl/Job/$applicationId');

    var response = await http.patch(
      url,
      headers: headers,
      body: jsonEncode({
        // Correct key-value format
        'jobStatus': status
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update application');
    }
  }

  // Update Application Data API
  static Future<Map<String, dynamic>> updateApplicationStatus(
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

//..........................
//POST REQUESTS

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

  static Future<http.StreamedResponse> sendManagerData({
    required String managerName,
    required String email,
    Uint8List? selectedImage,
    String? imageFilename,
  }) async {
    final url = Uri.parse('$baseUrl/company/manager');

    // Prepare form data
    var request = http.MultipartRequest('POST', url);
    // Assuming headers are defined somewhere in your code
    request.headers.addAll(headers);
    request.fields['managerName'] = managerName;
    request.fields['managerMail'] = email;

    // Check if selectedImage and imageFilename are not null and add them to the request
    if (selectedImage != null && imageFilename != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'image', // Key name for the server
          selectedImage,
          filename: imageFilename,
        ),
      );
    }

    try {
      // Send the request and return the response
      var response = await request.send();
      return response;
    } catch (error) {
      rethrow; // Rethrow any errors to handle them in the UI
    }
  }

// Update AddressDetails Data API
  // static Future<Map<String, dynamic>> sendUpdatedCompanyData({
  static Future<http.Response> sendUpdatedCompanyData(
      {required String address,
      required String site,
      required int number,
      required String about}) async {
    // Construct the URL
    final url = Uri.parse('$baseUrl/user'); // Adjust the endpoint as necessary

    // Create the request body
    final Map<String, String> body = {
      'address': address,
      'company_website': site,
      'contact': number.toString(),
      'about_company': about,
    };

    // Send the request
    final response = await http.patch(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    return response; // Ensure you return the response
  }
  //..............................................................

  //user Section

  static Future<Map<String, List<String>>> fetchDropdownBoxItems() async {
    final url = Uri.parse('$baseUrl/job/dropbox');

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      // print('Response status: ${response.statusCode}');
      // print('DropBox: ${response.body}');

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
