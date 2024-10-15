// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CompanyApiResponse welcomeFromJson(String str) => CompanyApiResponse.fromJson(json.decode(str));

String welcomeToJson(CompanyApiResponse data) => json.encode(data.toJson());

class CompanyApiResponse {
    String message;
    CompanyData companyData;

    CompanyApiResponse({
        required this.message,
        required this.companyData,
    });

    factory CompanyApiResponse.fromJson(Map<String, dynamic> json) => CompanyApiResponse(
        message: json["message"],
        companyData: CompanyData.fromJson(json["companyData"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "companyData": companyData.toJson(),
    };
}

class CompanyData {
    CommonData commonData;
    StatisticsPageData statisticsPageData;
    ApplicantsPageData applicantsPageData;
    List<JobsPageDatum> jobsPageData;

    CompanyData({
        required this.commonData,
        required this.statisticsPageData,
        required this.applicantsPageData,
        required this.jobsPageData,
    });

    factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
        commonData: CommonData.fromJson(json["commonData"]),
        statisticsPageData: StatisticsPageData.fromJson(json["statisticsPageData"]),
        applicantsPageData: ApplicantsPageData.fromJson(json["applicantsPageData"]),
        jobsPageData: List<JobsPageDatum>.from(json["jobsPageData"].map((x) => JobsPageDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "commonData": commonData.toJson(),
        "statisticsPageData": statisticsPageData.toJson(),
        "applicantsPageData": applicantsPageData.toJson(),
        "jobsPageData": List<dynamic>.from(jobsPageData.map((x) => x.toJson())),
    };
}

class ApplicantsPageData {
    List<Pending> pending;
    List<Selected> selected;

    ApplicantsPageData({
        required this.pending,
        required this.selected,
    });

    factory ApplicantsPageData.fromJson(Map<String, dynamic> json) => ApplicantsPageData(
        pending: List<Pending>.from(json["pending"].map((x) => Pending.fromJson(x))),
        selected: List<Selected>.from(json["selected"].map((x) => Selected.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pending": List<dynamic>.from(pending.map((x) => x.toJson())),
        "selected": List<dynamic>.from(selected.map((x) => x.toJson())),
    };
}

class Pending {
    int applicationId;
    DateTime date;
    String applicantName;
    String location;
    String designation;
    String resumeLink;
    String email;
    String status;

    Pending({
        required this.applicationId,
        required this.date,
        required this.applicantName,
        required this.location,
        required this.designation,
        required this.resumeLink,
        required this.email,
        required this.status,
    });

    factory Pending.fromJson(Map<String, dynamic> json) => Pending(
        applicationId: json["applicationId"],
        date: DateTime.parse(json["date"]),
        applicantName: json["applicantName"],
        location: json["location"],
        designation: json["designation"],
        resumeLink: json["resumeLink"],
        email: json["email"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "applicationId": applicationId,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "applicantName": applicantName,
        "location": location,
        "designation": designation,
        "resumeLink": resumeLink,
        "email": email,
        "status": status,
    };
}

class Selected {
    int applicantId;
    String name;
    String designation;

    Selected({
        required this.applicantId,
        required this.name,
        required this.designation,
    });

    factory Selected.fromJson(Map<String, dynamic> json) => Selected(
        applicantId: json["applicantId"],
        name: json["name"],
        designation: json["designation"],
    );

    Map<String, dynamic> toJson() => {
        "applicantId": applicantId,
        "name": name,
        "designation": designation,
    };
}

class CommonData {
    int companyPosition;
    Applicants applicantsTotal;
    Applicants applicantsSelected;
    MostAppliedJob mostAppliedJob;

    CommonData({
        required this.companyPosition,
        required this.applicantsTotal,
        required this.applicantsSelected,
        required this.mostAppliedJob,
    });

    factory CommonData.fromJson(Map<String, dynamic> json) => CommonData(
        companyPosition: json["companyPosition"],
        applicantsTotal: Applicants.fromJson(json["applicantsTotal"]),
        applicantsSelected: Applicants.fromJson(json["applicantsSelected"]),
        mostAppliedJob: MostAppliedJob.fromJson(json["mostAppliedJob"]),
    );

    Map<String, dynamic> toJson() => {
        "companyPosition": companyPosition,
        "applicantsTotal": applicantsTotal.toJson(),
        "applicantsSelected": applicantsSelected.toJson(),
        "mostAppliedJob": mostAppliedJob.toJson(),
    };
}

class Applicants {
    int prevMonth;
    int thisMonth;
    int growth;

    Applicants({
        required this.prevMonth,
        required this.thisMonth,
        required this.growth,
    });

    factory Applicants.fromJson(Map<String, dynamic> json) => Applicants(
        prevMonth: json["prevMonth"],
        thisMonth: json["thisMonth"],
        growth: json["growth"],
    );

    Map<String, dynamic> toJson() => {
        "prevMonth": prevMonth,
        "thisMonth": thisMonth,
        "growth": growth,
    };
}

class MostAppliedJob {
    String title;
    int applicantsCount;
    String growth;

    MostAppliedJob({
        required this.title,
        required this.applicantsCount,
        required this.growth,
    });

    factory MostAppliedJob.fromJson(Map<String, dynamic> json) => MostAppliedJob(
        title: json["title"],
        applicantsCount: json["applicantsCount"],
        growth: json["growth"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "applicantsCount": applicantsCount,
        "growth": growth,
    };
}

class JobsPageDatum {
    int jobId;
    String designation;
    String experience;
    String location;
    int vacancy;
    int selected;
    String jobMode;
    String jobType;
    int salary;
    String status;

    JobsPageDatum({
        required this.jobId,
        required this.designation,
        required this.experience,
        required this.location,
        required this.vacancy,
        required this.selected,
        required this.jobMode,
        required this.jobType,
        required this.salary,
        required this.status,
    });

    factory JobsPageDatum.fromJson(Map<String, dynamic> json) => JobsPageDatum(
        jobId: json["jobId"],
        designation: json["designation"],
        experience: json["experience"],
        location: json["location"],
        vacancy: json["vacancy"],
        selected: json["selected"],
        jobMode: json["job_mode"],
        jobType: json["job_type"],
        salary: json["salary"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "jobId": jobId,
        "designation": designation,
        "experience": experience,
        "location": location,
        "vacancy": vacancy,
        "selected": selected,
        "job_mode": jobMode,
        "job_type": jobType,
        "salary": salary,
        "status": status,
    };
}

class StatisticsPageData {
    List<Recruitment> recruitment;

    StatisticsPageData({
        required this.recruitment,
    });

    factory StatisticsPageData.fromJson(Map<String, dynamic> json) => StatisticsPageData(
        recruitment: List<Recruitment>.from(json["recruitment"].map((x) => Recruitment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "recruitment": List<dynamic>.from(recruitment.map((x) => x.toJson())),
    };
}

class Recruitment {
    String jobTitle;
    int prevMonth;
    int currentMonth;

    Recruitment({
        required this.jobTitle,
        required this.prevMonth,
        required this.currentMonth,
    });

    factory Recruitment.fromJson(Map<String, dynamic> json) => Recruitment(
        jobTitle: json["jobTitle"],
        prevMonth: json["prevMonth"],
        currentMonth: json["currentMonth"],
    );

    Map<String, dynamic> toJson() => {
        "jobTitle": jobTitle,
        "prevMonth": prevMonth,
        "currentMonth": currentMonth,
    };
}
