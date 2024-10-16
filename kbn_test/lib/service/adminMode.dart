// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AdminApiResponse welcomeFromJson(String str) => AdminApiResponse.fromJson(json.decode(str));

String welcomeToJson(AdminApiResponse data) => json.encode(data.toJson());

class AdminApiResponse {
    String message;
    AdminData adminData;

    AdminApiResponse({
        required this.message,
        required this.adminData,
    });

    factory AdminApiResponse.fromJson(Map<String, dynamic> json) => AdminApiResponse(
        message: json["message"],
        adminData: AdminData.fromJson(json["adminData"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "adminData": adminData.toJson(),
    };
}

class AdminData {
    CommonData commonData;
    StatisticsPageData statisticsPageData;
    CompaniesPageData companiesPageData;

    AdminData({
        required this.commonData,
        required this.statisticsPageData,
        required this.companiesPageData,
    });

    factory AdminData.fromJson(Map<String, dynamic> json) => AdminData(
        commonData: CommonData.fromJson(json["commonData"]),
        statisticsPageData: StatisticsPageData.fromJson(json["statisticsPageData"]),
        companiesPageData: CompaniesPageData.fromJson(json["companiesPageData"]),
    );

    Map<String, dynamic> toJson() => {
        "commonData": commonData.toJson(),
        "statisticsPageData": statisticsPageData.toJson(),
        "companiesPageData": companiesPageData.toJson(),
    };
}

class CommonData {
    BestCompany bestCompany;
    int companiesAdded;
    int kbnCodeAdded;
    MostAppliedCompany mostAppliedCompany;
    int totalGrowth;

    CommonData({
        required this.bestCompany,
        required this.companiesAdded,
        required this.kbnCodeAdded,
        required this.mostAppliedCompany,
        required this.totalGrowth,
    });

    factory CommonData.fromJson(Map<String, dynamic> json) => CommonData(
        bestCompany: BestCompany.fromJson(json["bestCompany"]),
        companiesAdded: json["companiesAdded"],
        kbnCodeAdded: json["kbnCodeAdded"],
        mostAppliedCompany: MostAppliedCompany.fromJson(json["mostAppliedCompany"]),
        totalGrowth: json["totalGrowth"],
    );

    Map<String, dynamic> toJson() => {
        "bestCompany": bestCompany.toJson(),
        "companiesAdded": companiesAdded,
        "kbnCodeAdded": kbnCodeAdded,
        "mostAppliedCompany": mostAppliedCompany.toJson(),
        "totalGrowth": totalGrowth,
    };
}

class BestCompany {
    int companyId;
    String companyName;
    int totalApplications;

    BestCompany({
        required this.companyId,
        required this.companyName,
        required this.totalApplications,
    });

    factory BestCompany.fromJson(Map<String, dynamic> json) => BestCompany(
        companyId: json["companyId"],
        companyName: json["companyName"],
        totalApplications: json["totalApplications"],
    );

    Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "companyName": companyName,
        "totalApplications": totalApplications,
    };
}

class MostAppliedCompany {
    int companyId;
    String companyName;
    int applicationCount;
    String applicationPercentage;

    MostAppliedCompany({
        required this.companyId,
        required this.companyName,
        required this.applicationCount,
        required this.applicationPercentage,
    });

    factory MostAppliedCompany.fromJson(Map<String, dynamic> json) => MostAppliedCompany(
        companyId: json["companyId"],
        companyName: json["companyName"],
        applicationCount: json["applicationCount"],
        applicationPercentage: json["applicationPercentage"],
    );

    Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "companyName": companyName,
        "applicationCount": applicationCount,
        "applicationPercentage": applicationPercentage,
    };
}

class CompaniesPageData {
    List<ApprovedCompany> approvedCompanies;
    List<ToBeApprovedCompany> toBeApprovedCompanies;

    CompaniesPageData({
        required this.approvedCompanies,
        required this.toBeApprovedCompanies,
    });

    factory CompaniesPageData.fromJson(Map<String, dynamic> json) => CompaniesPageData(
        approvedCompanies: List<ApprovedCompany>.from(json["approvedCompanies"].map((x) => ApprovedCompany.fromJson(x))),
        toBeApprovedCompanies: List<ToBeApprovedCompany>.from(json["toBeApprovedCompanies"].map((x) => ToBeApprovedCompany.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "approvedCompanies": List<dynamic>.from(approvedCompanies.map((x) => x.toJson())),
        "toBeApprovedCompanies": List<dynamic>.from(toBeApprovedCompanies.map((x) => x.toJson())),
    };
}

class ApprovedCompany {
    int companyId;
    String companyName;
    DateTime date;
    dynamic kbnCode;
    String totalVacancy;
    int selected;
    String adminStatus;

    ApprovedCompany({
        required this.companyId,
        required this.companyName,
        required this.date,
        required this.kbnCode,
        required this.totalVacancy,
        required this.selected,
        required this.adminStatus,
    });

    factory ApprovedCompany.fromJson(Map<String, dynamic> json) => ApprovedCompany(
        companyId: json["companyId"],
        companyName: json["companyName"],
        date: DateTime.parse(json["date"]),
        kbnCode: json["kbn_code"],
        totalVacancy: json["totalVacancy"],
        selected: json["selected"],
        adminStatus: json["adminStatus"],
    );

    Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "companyName": companyName,
        "date": date.toIso8601String(),
        "kbn_code": kbnCode,
        "totalVacancy": totalVacancy,
        "selected": selected,
        "adminStatus": adminStatus,
    };
}

class ToBeApprovedCompany {
    int companyId;
    String companyName;
    dynamic website;

    ToBeApprovedCompany({
        required this.companyId,
        required this.companyName,
        required this.website,
    });

    factory ToBeApprovedCompany.fromJson(Map<String, dynamic> json) => ToBeApprovedCompany(
        companyId: json["companyId"],
        companyName: json["companyName"],
        website: json["website"],
    );

    Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "companyName": companyName,
        "website": website,
    };
}

class StatisticsPageData {
    List<Performance> performance;
    int currMonthTotalApplicants;
    int currMonthSelectedApplicants;
    int prevMonthTotalApplicants;
    int prevMonthSelectedApplicants;

    StatisticsPageData({
        required this.performance,
        required this.currMonthTotalApplicants,
        required this.currMonthSelectedApplicants,
        required this.prevMonthTotalApplicants,
        required this.prevMonthSelectedApplicants,
    });

    factory StatisticsPageData.fromJson(Map<String, dynamic> json) => StatisticsPageData(
        performance: List<Performance>.from(json["performance"].map((x) => Performance.fromJson(x))),
        currMonthTotalApplicants: json["currMonthTotalApplicants"],
        currMonthSelectedApplicants: json["currMonthSelectedApplicants"],
        prevMonthTotalApplicants: json["prevMonthTotalApplicants"],
        prevMonthSelectedApplicants: json["prevMonthSelectedApplicants"],
    );

    Map<String, dynamic> toJson() => {
        "performance": List<dynamic>.from(performance.map((x) => x.toJson())),
        "currMonthTotalApplicants": currMonthTotalApplicants,
        "currMonthSelectedApplicants": currMonthSelectedApplicants,
        "prevMonthTotalApplicants": prevMonthTotalApplicants,
        "prevMonthSelectedApplicants": prevMonthSelectedApplicants,
    };
}

class Performance {
    String companyName;
    String performancePercentageThisMonth;
    String performancePercentagePrevMonth;

    Performance({
        required this.companyName,
        required this.performancePercentageThisMonth,
        required this.performancePercentagePrevMonth,
    });

    factory Performance.fromJson(Map<String, dynamic> json) => Performance(
        companyName: json["companyName"],
        performancePercentageThisMonth: json["performancePercentageThisMonth"],
        performancePercentagePrevMonth: json["performancePercentagePrevMonth"],
    );

    Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "performancePercentageThisMonth": performancePercentageThisMonth,
        "performancePercentagePrevMonth": performancePercentagePrevMonth,
    };
}
