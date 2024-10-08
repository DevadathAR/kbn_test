// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Apiresponse welcomeFromJson(String str) => Apiresponse.fromJson(json.decode(str));

String welcomeToJson(Apiresponse data) => json.encode(data.toJson());

class Apiresponse {
    String message;
    CompanyData companyData;

    Apiresponse({
        required this.message,
        required this.companyData,
    });

    factory Apiresponse.fromJson(Map<String, dynamic> json) => Apiresponse(
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
    List<MessagesPageDatum> messagesPageData;

    CompanyData({
        required this.commonData,
        required this.statisticsPageData,
        required this.applicantsPageData,
        required this.jobsPageData,
        required this.messagesPageData,
    });

    factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
        commonData: CommonData.fromJson(json["commonData"]),
        statisticsPageData: StatisticsPageData.fromJson(json["statisticsPageData"]),
        applicantsPageData: ApplicantsPageData.fromJson(json["applicantsPageData"]),
        jobsPageData: List<JobsPageDatum>.from(json["jobsPageData"].map((x) => JobsPageDatum.fromJson(x))),
        messagesPageData: List<MessagesPageDatum>.from(json["messagesPageData"].map((x) => MessagesPageDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "commonData": commonData.toJson(),
        "statisticsPageData": statisticsPageData.toJson(),
        "applicantsPageData": applicantsPageData.toJson(),
        "jobsPageData": List<dynamic>.from(jobsPageData.map((x) => x.toJson())),
        "messagesPageData": List<dynamic>.from(messagesPageData.map((x) => x.toJson())),
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
    DateTime date;
    String applicantName;
    Location location;
    String designation;
    ResumeLink resumeLink;
    String email;
    Status status;

    Pending({
        required this.date,
        required this.applicantName,
        required this.location,
        required this.designation,
        required this.resumeLink,
        required this.email,
        required this.status,
    });

    factory Pending.fromJson(Map<String, dynamic> json) => Pending(
        date: DateTime.parse(json["date"]),
        applicantName: json["applicantName"],
        location: locationValues.map[json["location"]]!,
        designation: json["designation"],
        resumeLink: resumeLinkValues.map[json["resumeLink"]]!,
        email: json["email"],
        status: statusValues.map[json["status"]]!,
    );

    Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "applicantName": applicantName,
        "location": locationValues.reverse[location],
        "designation": designation,
        "resumeLink": resumeLinkValues.reverse[resumeLink],
        "email": email,
        "status": statusValues.reverse[status],
    };
}

enum Location {
    BRAZIL,
    CALICUT,
    KAKKANAD,
    KOCHI,
    LOCATION_KOCHI
}

final locationValues = EnumValues({
    "brazil": Location.BRAZIL,
    "calicut": Location.CALICUT,
    "kakkanad": Location.KAKKANAD,
    "kochi": Location.KOCHI,
    "Kochi": Location.LOCATION_KOCHI
});

enum ResumeLink {
    UPLOADS_DEVADATH_AR_PDF,
    UPLOADS_RECTANGLE_740_PNG
}

final resumeLinkValues = EnumValues({
    "/uploads/Devadath.AR.pdf": ResumeLink.UPLOADS_DEVADATH_AR_PDF,
    "/uploads/Rectangle 740.png": ResumeLink.UPLOADS_RECTANGLE_740_PNG
});

enum Status {
    SUBMITTED
}

final statusValues = EnumValues({
    "submitted": Status.SUBMITTED
});

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
    Location location;
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
        location: locationValues.map[json["location"]]!,
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
        "location": locationValues.reverse[location],
        "vacancy": vacancy,
        "selected": selected,
        "job_mode": jobMode,
        "job_type": jobType,
        "salary": salary,
        "status": status,
    };
}

class MessagesPageDatum {
    int threadId;
    int senderId;
    String sender;
    int receiverId;
    String content;
    dynamic files;
    DateTime createdAt;

    MessagesPageDatum({
        required this.threadId,
        required this.senderId,
        required this.sender,
        required this.receiverId,
        required this.content,
        required this.files,
        required this.createdAt,
    });

    factory MessagesPageDatum.fromJson(Map<String, dynamic> json) => MessagesPageDatum(
        threadId: json["threadId"],
        senderId: json["senderId"],
        sender: json["sender"],
        receiverId: json["receiverId"],
        content: json["content"],
        files: json["files"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "threadId": threadId,
        "senderId": senderId,
        "sender": sender,
        "receiverId": receiverId,
        "content": content,
        "files": files,
        "created_at": createdAt.toIso8601String(),
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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
