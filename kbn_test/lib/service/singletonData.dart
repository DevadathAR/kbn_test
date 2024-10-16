// import 'package:kbn_test/service/adminMode.dart';
// import 'package:kbn_test/service/apiServices.dart';
// import 'package:kbn_test/service/companymodelClass.dart';
// import 'package:kbn_test/veiw/auth/logInPage.dart'; 

// class ApiDataService {
//   static final ApiDataService _instance = ApiDataService._internal();
//     // bool isCompany = false; // Add this variable


//   CompanyApiResponse? _companyData; 
//   AdminApiResponse? _adminData; 

//   bool isCompanyDataFetched = false; 
//   bool isAdminDataFetched = false; 

//   ApiDataService._internal();

//   factory ApiDataService() {
//     return _instance;
//   }

//   // Fetch data based on the role with separate models for admin and company
//   Future<dynamic> fetchDataBasedOnRole() async {
//     isCompany? fetchCompanyData():fetchAdminData();
//   }

//   // Fetch company data with caching
//   Future<CompanyApiResponse> fetchCompanyData() async {
//     if (_companyData != null && isCompanyDataFetched) {
//       return _companyData!;
//     }
//     // Fetch from API if not already fetched
//     CompanyApiResponse response = await ApiServices.companyData();
//     _companyData = response;
//     isCompanyDataFetched = true;
//     return _companyData!;
//   }

//   // Fetch admin data with caching
//   Future<AdminApiResponse> fetchAdminData() async {
//     if (_adminData != null && isAdminDataFetched) {
//       return _adminData!;
//     }
//     // Fetch from API if not already fetched
//     AdminApiResponse response = await ApiServices.adminData();
//     _adminData = response; 
//     isAdminDataFetched = true;
//     return _adminData!;
//   }

//   // Clear cache for both company and admin data
//   void clearCache() {
//     _companyData = null;
//     _adminData = null;
//     isCompanyDataFetched = false;
//     isAdminDataFetched = false;
//   }
// }
