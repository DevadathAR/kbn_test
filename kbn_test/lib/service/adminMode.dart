class AdminApiResponse {
  String? message;
  AdminData? adminData;

  AdminApiResponse({this.message, this.adminData});

  AdminApiResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    adminData = json['adminData'] != null
        ? AdminData.fromJson(json['adminData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (adminData != null) {
      data['adminData'] = adminData!.toJson();
    }
    return data;
  }
}

class AdminData {
  CommonData? commonData;
  StatisticsPageData? statisticsPageData;
  CompaniesPageData? companiesPageData;

  AdminData({this.commonData, this.statisticsPageData, this.companiesPageData});

  AdminData.fromJson(Map<String, dynamic> json) {
    commonData = json['commonData'] != null
        ? CommonData.fromJson(json['commonData'])
        : null;
    statisticsPageData = json['statisticsPageData'] != null
        ? StatisticsPageData.fromJson(json['statisticsPageData'])
        : null;
    companiesPageData = json['companiesPageData'] != null
        ? CompaniesPageData.fromJson(json['companiesPageData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (commonData != null) {
      data['commonData'] = commonData!.toJson();
    }
    if (statisticsPageData != null) {
      data['statisticsPageData'] = statisticsPageData!.toJson();
    }
    if (companiesPageData != null) {
      data['companiesPageData'] = companiesPageData!.toJson();
    }
    return data;
  }
}

class CommonData {
  BestCompany? bestCompany;
  int? companiesAdded;
  int? kbnCodeAdded;
  MostAppliedCompany? mostAppliedCompany;
  int? totalGrowth;

  CommonData(
      {this.bestCompany,
      this.companiesAdded,
      this.kbnCodeAdded,
      this.mostAppliedCompany,
      this.totalGrowth});

  CommonData.fromJson(Map<String, dynamic> json) {
    bestCompany = json['bestCompany'] != null
        ? BestCompany.fromJson(json['bestCompany'])
        : null;
    companiesAdded = json['companiesAdded'];
    kbnCodeAdded = json['kbnCodeAdded'];
    mostAppliedCompany = json['mostAppliedCompany'] != null
        ? MostAppliedCompany.fromJson(json['mostAppliedCompany'])
        : null;
    totalGrowth = json['totalGrowth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bestCompany != null) {
      data['bestCompany'] = bestCompany!.toJson();
    }
    data['companiesAdded'] = companiesAdded;
    data['kbnCodeAdded'] = kbnCodeAdded;
    if (mostAppliedCompany != null) {
      data['mostAppliedCompany'] = mostAppliedCompany!.toJson();
    }
    data['totalGrowth'] = totalGrowth;
    return data;
  }
}

class BestCompany {
  int? companyId;
  String? companyName;
  int? totalApplications;

  BestCompany({this.companyId, this.companyName, this.totalApplications});

  BestCompany.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    companyName = json['companyName'];
    totalApplications = json['totalApplications'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyId'] = companyId;
    data['companyName'] = companyName;
    data['totalApplications'] = totalApplications;
    return data;
  }
}

class MostAppliedCompany {
  int? companyId;
  String? companyName;
  int? applicationCount;
  String? applicationPercentage;

  MostAppliedCompany(
      {this.companyId,
      this.companyName,
      this.applicationCount,
      this.applicationPercentage});

  MostAppliedCompany.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    companyName = json['companyName'];
    applicationCount = json['applicationCount'];
    applicationPercentage = json['applicationPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyId'] = companyId;
    data['companyName'] = companyName;
    data['applicationCount'] = applicationCount;
    data['applicationPercentage'] = applicationPercentage;
    return data;
  }
}

class StatisticsPageData {
  List<Performance>? performance;
  int? currMonthTotalApplicants;
  int? currMonthSelectedApplicants;
  int? prevMonthTotalApplicants;
  int? prevMonthSelectedApplicants;

  StatisticsPageData(
      {this.performance,
      this.currMonthTotalApplicants,
      this.currMonthSelectedApplicants,
      this.prevMonthTotalApplicants,
      this.prevMonthSelectedApplicants});

  StatisticsPageData.fromJson(Map<String, dynamic> json) {
    if (json['performance'] != null) {
      performance = <Performance>[];
      json['performance'].forEach((v) {
        performance!.add(Performance.fromJson(v));
      });
    }
    currMonthTotalApplicants = json['currMonthTotalApplicants'];
    currMonthSelectedApplicants = json['currMonthSelectedApplicants'];
    prevMonthTotalApplicants = json['prevMonthTotalApplicants'];
    prevMonthSelectedApplicants = json['prevMonthSelectedApplicants'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (performance != null) {
      data['performance'] = performance!.map((v) => v.toJson()).toList();
    }
    data['currMonthTotalApplicants'] = currMonthTotalApplicants;
    data['currMonthSelectedApplicants'] = currMonthSelectedApplicants;
    data['prevMonthTotalApplicants'] = prevMonthTotalApplicants;
    data['prevMonthSelectedApplicants'] = prevMonthSelectedApplicants;
    return data;
  }
}

class Performance {
  String? companyName;
  String? performancePercentageThisMonth;
  String? performancePercentagePrevMonth;

  Performance(
      {this.companyName,
      this.performancePercentageThisMonth,
      this.performancePercentagePrevMonth});

  Performance.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    performancePercentageThisMonth = json['performancePercentageThisMonth'];
    performancePercentagePrevMonth = json['performancePercentagePrevMonth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyName'] = companyName;
    data['performancePercentageThisMonth'] = performancePercentageThisMonth;
    data['performancePercentagePrevMonth'] = performancePercentagePrevMonth;
    return data;
  }
}

class CompaniesPageData {
  List<ApprovedCompanies>? approvedCompanies;
  List<ToBeApprovedCompanies>? toBeApprovedCompanies;

  CompaniesPageData({this.approvedCompanies, this.toBeApprovedCompanies});

  CompaniesPageData.fromJson(Map<String, dynamic> json) {
    if (json['approvedCompanies'] != null) {
      approvedCompanies = <ApprovedCompanies>[];
      json['approvedCompanies'].forEach((v) {
        approvedCompanies!.add(ApprovedCompanies.fromJson(v));
      });
    }
    if (json['toBeApprovedCompanies'] != null) {
      toBeApprovedCompanies = <ToBeApprovedCompanies>[];
      json['toBeApprovedCompanies'].forEach((v) {
        toBeApprovedCompanies!.add(ToBeApprovedCompanies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (approvedCompanies != null) {
      data['approvedCompanies'] =
          approvedCompanies!.map((v) => v.toJson()).toList();
    }
    if (toBeApprovedCompanies != null) {
      data['toBeApprovedCompanies'] =
          toBeApprovedCompanies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApprovedCompanies {
  int? companyId;
  String? companyName;
  String? date;
  String? kbnCode;
  String? totalVacancy;
  int? selected;
  String? adminStatus;

  ApprovedCompanies(
      {this.companyId,
      this.companyName,
      this.date,
      this.kbnCode,
      this.totalVacancy,
      this.selected,
      this.adminStatus});

  ApprovedCompanies.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    companyName = json['companyName'];
    date = json['date'];
    kbnCode = json['kbn_code'];
    totalVacancy = json['totalVacancy'];
    selected = json['selected'];
    adminStatus = json['adminStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyId'] = companyId;
    data['companyName'] = companyName;
    data['date'] = date;
    data['kbn_code'] = kbnCode;
    data['totalVacancy'] = totalVacancy;
    data['selected'] = selected;
    data['adminStatus'] = adminStatus;
    return data;
  }
}

class ToBeApprovedCompanies {
  int? companyId;
  String? companyName;
  Null website;

  ToBeApprovedCompanies({this.companyId, this.companyName, this.website});

  ToBeApprovedCompanies.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    companyName = json['companyName'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyId'] = companyId;
    data['companyName'] = companyName;
    data['website'] = website;
    return data;
  }
}
