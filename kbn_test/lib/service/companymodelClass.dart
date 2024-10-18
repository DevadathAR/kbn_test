class CompanyApiResponse {
  String? message;
  CompanyData? companyData;

  CompanyApiResponse({this.message, this.companyData});

  CompanyApiResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    companyData = json['companyData'] != null
        ? CompanyData.fromJson(json['companyData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (companyData != null) {
      data['companyData'] = companyData!.toJson();
    }
    return data;
  }
}

class CompanyData {
  CommonData? commonData;
  StatisticsPageData? statisticsPageData;
  ApplicantsPageData? applicantsPageData;
  List<JobsPageData>? jobsPageData;

  CompanyData(
      {this.commonData,
      this.statisticsPageData,
      this.applicantsPageData,
      this.jobsPageData});

  CompanyData.fromJson(Map<String, dynamic> json) {
    commonData = json['commonData'] != null
        ? CommonData.fromJson(json['commonData'])
        : null;
    statisticsPageData = json['statisticsPageData'] != null
        ? StatisticsPageData.fromJson(json['statisticsPageData'])
        : null;
    applicantsPageData = json['applicantsPageData'] != null
        ? ApplicantsPageData.fromJson(json['applicantsPageData'])
        : null;
    if (json['jobsPageData'] != null) {
      jobsPageData = <JobsPageData>[];
      json['jobsPageData'].forEach((v) {
        jobsPageData!.add(JobsPageData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (commonData != null) {
      data['commonData'] = commonData!.toJson();
    }
    if (statisticsPageData != null) {
      data['statisticsPageData'] = statisticsPageData!.toJson();
    }
    if (applicantsPageData != null) {
      data['applicantsPageData'] = applicantsPageData!.toJson();
    }
    if (jobsPageData != null) {
      data['jobsPageData'] = jobsPageData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommonData {
  int? companyPosition;
  ApplicantsTotal? applicantsTotal;
  ApplicantsTotal? applicantsSelected;
  MostAppliedJob? mostAppliedJob;

  CommonData(
      {this.companyPosition,
      this.applicantsTotal,
      this.applicantsSelected,
      this.mostAppliedJob});

  CommonData.fromJson(Map<String, dynamic> json) {
    companyPosition = json['companyPosition'];
    applicantsTotal = json['applicantsTotal'] != null
        ? ApplicantsTotal.fromJson(json['applicantsTotal'])
        : null;
    applicantsSelected = json['applicantsSelected'] != null
        ? ApplicantsTotal.fromJson(json['applicantsSelected'])
        : null;
    mostAppliedJob = json['mostAppliedJob'] != null
        ? MostAppliedJob.fromJson(json['mostAppliedJob'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyPosition'] = companyPosition;
    if (applicantsTotal != null) {
      data['applicantsTotal'] = applicantsTotal!.toJson();
    }
    if (applicantsSelected != null) {
      data['applicantsSelected'] = applicantsSelected!.toJson();
    }
    if (mostAppliedJob != null) {
      data['mostAppliedJob'] = mostAppliedJob!.toJson();
    }
    return data;
  }
}

class ApplicantsTotal {
  int? prevMonth;
  int? thisMonth;
  int? growth;

  ApplicantsTotal({this.prevMonth, this.thisMonth, this.growth});

  ApplicantsTotal.fromJson(Map<String, dynamic> json) {
    prevMonth = json['prevMonth'];
    thisMonth = json['thisMonth'];
    growth = json['growth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prevMonth'] = prevMonth;
    data['thisMonth'] = thisMonth;
    data['growth'] = growth;
    return data;
  }
}

class MostAppliedJob {
  String? title;
  int? applicantsCount;
  String? growth;

  MostAppliedJob({this.title, this.applicantsCount, this.growth});

  MostAppliedJob.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    applicantsCount = json['applicantsCount'];
    growth = json['growth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['applicantsCount'] = applicantsCount;
    data['growth'] = growth;
    return data;
  }
}

class StatisticsPageData {
  List<Recruitment>? recruitment;

  StatisticsPageData({this.recruitment});

  StatisticsPageData.fromJson(Map<String, dynamic> json) {
    if (json['recruitment'] != null) {
      recruitment = <Recruitment>[];
      json['recruitment'].forEach((v) {
        recruitment!.add(Recruitment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recruitment != null) {
      data['recruitment'] = recruitment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recruitment {
  String? jobTitle;
  int? prevMonth;
  int? currentMonth;

  Recruitment({this.jobTitle, this.prevMonth, this.currentMonth});

  Recruitment.fromJson(Map<String, dynamic> json) {
    jobTitle = json['jobTitle'];
    prevMonth = json['prevMonth'];
    currentMonth = json['currentMonth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jobTitle'] = jobTitle;
    data['prevMonth'] = prevMonth;
    data['currentMonth'] = currentMonth;
    return data;
  }
}

class ApplicantsPageData {
  List<Pending>? pending;
  List<Selected>? selected;

  ApplicantsPageData({this.pending, this.selected});

  ApplicantsPageData.fromJson(Map<String, dynamic> json) {
    if (json['pending'] != null) {
      pending = <Pending>[];
      json['pending'].forEach((v) {
        pending!.add(Pending.fromJson(v));
      });
    }
    if (json['selected'] != null) {
      selected = <Selected>[];
      json['selected'].forEach((v) {
        selected!.add(Selected.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pending != null) {
      data['pending'] = pending!.map((v) => v.toJson()).toList();
    }
    if (selected != null) {
      data['selected'] = selected!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pending {
  int? applicationId;
  String? date;
  String? applicantName;
  String? location;
  String? designation;
  String? resumeLink;
  String? email;
  String? status;

  Pending(
      {this.applicationId,
      this.date,
      this.applicantName,
      this.location,
      this.designation,
      this.resumeLink,
      this.email,
      this.status});

  Pending.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    date = json['date'];
    applicantName = json['applicantName'];
    location = json['location'];
    designation = json['designation'];
    resumeLink = json['resumeLink'];
    email = json['email'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['applicationId'] = applicationId;
    data['date'] = date;
    data['applicantName'] = applicantName;
    data['location'] = location;
    data['designation'] = designation;
    data['resumeLink'] = resumeLink;
    data['email'] = email;
    data['status'] = status;
    return data;
  }
}

class Selected {
  int? applicantId;
  String? name;
  String? designation;

  Selected({this.applicantId, this.name, this.designation});

  Selected.fromJson(Map<String, dynamic> json) {
    applicantId = json['applicantId'];
    name = json['name'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['applicantId'] = applicantId;
    data['name'] = name;
    data['designation'] = designation;
    return data;
  }
}

class JobsPageData {
  int? jobId;
  String? designation;
  String? experience;
  String? location;
  int? vacancy;
  int? selected;
  String? jobMode;
  String? jobType;
  int? salary;
  String? status;

  JobsPageData(
      {this.jobId,
      this.designation,
      this.experience,
      this.location,
      this.vacancy,
      this.selected,
      this.jobMode,
      this.jobType,
      this.salary,
      this.status});

  JobsPageData.fromJson(Map<String, dynamic> json) {
    jobId = json['jobId'];
    designation = json['designation'];
    experience = json['experience'];
    location = json['location'];
    vacancy = json['vacancy'];
    selected = json['selected'];
    jobMode = json['job_mode'];
    jobType = json['job_type'];
    salary = json['salary'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jobId'] = jobId;
    data['designation'] = designation;
    data['experience'] = experience;
    data['location'] = location;
    data['vacancy'] = vacancy;
    data['selected'] = selected;
    data['job_mode'] = jobMode;
    data['job_type'] = jobType;
    data['salary'] = salary;
    data['status'] = status;
    return data;
  }
}
