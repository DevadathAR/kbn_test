import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/modelClass.dart';

class ApiDataService {
  static final ApiDataService _instance = ApiDataService._internal();
  Apiresponse? _cachedData; // Cache the data
  bool isDataFetched = false;

  ApiDataService._internal();

  factory ApiDataService() {
    return _instance;
  }

  Future<Apiresponse> fetchCompanyData() async {
    if (_cachedData != null && isDataFetched) {
      return _cachedData!;
    }
    // Fetch from API if not already fetched
    Apiresponse data = await ApiServices.companyData();
    _cachedData = data;
    isDataFetched = true;
    return data;
  }

  void clearCache() {
    _cachedData = null;
    isDataFetched = false;
  }
}
