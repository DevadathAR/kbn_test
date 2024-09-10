import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Map<String, dynamic> userDetails = {};
Map<String, dynamic> jobDetailsResponse = {};
List<dynamic> jobs = [];
String? token; // Token should be nullable to check its presence

const String baseUrl = 'http://192.168.29.37:8000';
const String baseUrl2 = 'http://192.168.29.197:5500';

class ApiServices {

  // Login API
  static Future<Map<String, dynamic>> userLogin(String email, String password) async {
    var url = Uri.parse('$baseUrl/user/login');

    var response = await http.post(
      url,
      
      body: jsonEncode({
        'email': email,
        'password': password,
        'loginType': "Applicant",
      }),
      headers: {'Content-Type': 'application/json'},
    );

    print("Login response: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      token = data['token']; // Save the token for future requests
      return data;
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  // Company login API
  static Future<Map<String, dynamic>> companyLogin(String email, String password) async {
    var url = Uri.parse('$baseUrl/user/login');

    var response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'password': password,
        'loginType': "Company",
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Company login failed: ${response.body}');
    }
  }

  // Fetch User Details API
  static Future<Map<String, dynamic>> fetchUserDetails() async {
    if (token == null) {
      throw Exception('Token is not available, please login first.');
    }

    var url = Uri.parse('$baseUrl/user/loggedIn');

    print("Fetching user details with token: $token");

    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch user details: ${response.body}');
    }
  }

  // Fetch Job Titles API
  static Future<List<dynamic>> fetchJobTitles() async {
    var url = Uri.parse('$baseUrl2/job/filter');

    var response = await http.get(url,
          headers: {'Authorization': 'Bearer $token'},
);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log(jsonEncode(data));
      return data['data'] as List;
    } else {
      throw Exception('Failed to fetch job titles');
    }
  }

  // Post Job Details API
  static Future<void> postJobDetails(int jobId, int companyId) async {
    if (token == null) {
      throw Exception('Token is not available, please login first.');
    }

    var url = Uri.parse('$baseUrl2/job/$jobId');

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'companyId': companyId}),
    );

    if (response.statusCode == 200) {
      print("Job details posted successfully.");
    } else {
      throw Exception('Failed to post job details: ${response.body}');
    }
  }

  // Apply for Job API
  static Future<Map<String, dynamic>> applyForJob(int jobId, int userId) async {
    if (token == null) {
      throw Exception('Token is not available, please login first.');
    }

    final url = Uri.parse('$baseUrl2/application/create');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'jobId': jobId, 'userId': userId}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to apply for job: ${response.body}');
    }
  }

  // Fetch Filter Data
  static Future<Map<String, List<String>>> fetchFilterData() async {
    final url = Uri.parse('$baseUrl2/job/filter');

    final response = await http.get(url,
          headers: {'Authorization': 'Bearer $token'},
);

print(jsonEncode(response.body));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> jobs = data['data'];

      // Parse distinct filter values
      final jobTypes = jobs.map((job) => job['job_type'].toString()).toSet().toList();
      final experiences = jobs.map((job) => job['experience_level'].toString()).toSet().toList();
      final workModes = jobs.map((job) => job['job_mode'].toString()).toSet().toList();
      final locations = jobs.map((job) => job['location'].toString()).toSet().toList();

      return {
        'jobTypes': jobTypes,
        'experiences': experiences,
        'workModes': workModes,
        'locations': locations,
      };
    } else {
      throw Exception("Failed to load filter data");
    }
  }

  // Fetch Filtered Jobs
  static Future<List<dynamic>> fetchFilteredJobs({
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

    // Handle salary splitting logic
    if (selectedSalary != null && selectedSalary != "Salary") {
      List<String> salaryParts = selectedSalary.split('-');
      if (salaryParts.length == 2) {
        minSalary = int.tryParse(salaryParts[0]);
        maxSalary = int.tryParse(salaryParts[1]);
      }
    }

    // Build query parameters for the request
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
      'pageSize': pageSize.toString(), // Always pass page size
    };

    final uri = Uri.parse('$baseUrl2/job/filter').replace(queryParameters: queryParameters);

    final response = await http.get(uri,
     headers: {'Authorization': 'Bearer $token'},);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'] as List;
    } else {
      throw Exception("Failed to fetch filtered jobs");
    }
  }
}
