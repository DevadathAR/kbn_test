import 'package:flutter/material.dart';
import 'package:kbn_test/service/api_service.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/date.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/user_auth/UserLoginPage.dart';
import 'package:kbn_test/veiw/screen/user_screen/termsandcond_applicant.dart';
import 'package:kbn_test/veiw/widgets/home_appbar_box.dart';
import 'package:kbn_test/veiw/widgets/jobsummury.dart';

class JobDetails extends StatefulWidget {
  final String firmname;
  final String jobTitle;
  final String jobSummary;
  final String expLevel;
  final String jobMode;
  final String jobType;
  final List<dynamic> keyResponsibilities;
  final int salary;
  final int currentVacancy;
  final String workLocation;
  final int jobId;
  final int companyId;
  final String companywebsite;
  final String datePosted;
  final String companyImage;
  final Map<String, dynamic> jobReq;

  const JobDetails(
      {Key? key,
      required this.firmname,
      required this.jobTitle,
      required this.jobSummary,
      required this.expLevel,
      required this.jobMode,
      required this.jobType,
      required this.keyResponsibilities,
      required this.salary,
      required this.currentVacancy,
      required this.workLocation,
      required this.jobId,
      required this.companyId,
      required this.companywebsite,
      required this.datePosted,
      required this.companyImage,
      required this.jobReq})
      : super(key: key);

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              width: size.width * 1,
              child: Column(
                children: [
                  const Center(child: Image(image: AssetImage(kbnLogo))),
                  HomeAppBarBox(context,
                      T_and_C: const TaC(),
                      logOutTo: const UserLoginPage(),
                      profileImage:
                          "${ApiServices.baseUrl}/${userDetails['user']['profile_image']}",
                      termscolor: white),
                  const SizedBox(height: 10),
                  Container(
                    height: 100,
                    width: size.width * 1,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      color: tealblue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 30),
                    child: Container(
                      width: size.width * 1,
                      height: size.height * .65,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: shadowblack,
                            spreadRadius: .1,
                            blurRadius: 5,
                            offset: Offset(1, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.width * 0.4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: CompanyDetails1(
                                      jobTitle: widget.jobTitle,
                                      firmname: widget.firmname,
                                      companywebsite: widget.companywebsite,
                                      companyImage: widget.companyImage,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25),
                                  child: VerticalDivider(color: shadowblack),
                                ),
                                CompanyDetails2(size),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25),
                                  child: VerticalDivider(color: shadowblack),
                                ),
                                CompanyDetails3(size),
                              ],
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Text(calculateDaysAgo(widget.datePosted)))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView CompanyDetails3(Size size) {
    Map<String, dynamic> reqlist = widget.jobReq;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SizedBox(
          width: size.width * .25,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Job Requirements",
                  style: AppTextStyle.abouttxt,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Skills:",
                      style: AppTextStyle.normaltxt,
                    ),
                  ),
                  ...reqlist['skills'].map((skill) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '• ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Expanded(
                            child: Text(
                              skill.toString(),
                              style: AppTextStyle.normaltxt,
                            ),
                          ),
                        ],
                      )),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Experience:",
                      style: AppTextStyle.normaltxt,
                    ),
                  ),
                  ...reqlist['experience'].map((exp) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '• ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Expanded(
                            child: Text(
                              exp.toString(),
                              style: AppTextStyle.normaltxt,
                            ),
                          ),
                        ],
                      )),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Educational Background:",
                      style: AppTextStyle.normaltxt,
                    ),
                  ),
                  ...reqlist['educational_background'].map((edu) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '• ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Expanded(
                            child: Text(
                              edu.toString(),
                              style: AppTextStyle.normaltxt,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView CompanyDetails2(Size size) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SizedBox(
          width: size.width * .25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Job Summary",
                  style: AppTextStyle.abouttxt,
                ),
              ),
              Text(
                widget.jobSummary,
                style: AppTextStyle.normaltxt,
                softWrap: true,
              ),
              JobSummaryWid(jobicon: bagPng, txt: widget.expLevel),
              JobSummaryWid(
                  jobicon: vacancyPng,
                  txt: " ${widget.currentVacancy.toString()} vacancy"),
              JobSummaryWid(
                  jobicon: locattionPng,
                  txt: "${widget.workLocation},${widget.jobMode}"),
              JobSummaryWid(
                  jobicon: salaryPng, txt: "${widget.salary} per month"),
              JobSummaryWid(jobicon: clockPng, txt: widget.jobMode),
              SizedBox(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Key Responsibilities",
                        style: AppTextStyle.abouttxt,
                      ),
                    ),
                    const SizedBox(height: 10),
                    for (var item in widget.keyResponsibilities)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '• ',
                              style: TextStyle(fontSize: 20),
                            ),
                            Expanded(
                              child: Text(
                                item.trim(),
                                style: AppTextStyle.normaltxt,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CompanyDetails1 extends StatefulWidget {
  final String jobTitle;
  final String firmname;
  final String companywebsite;
  final String companyImage;

  const CompanyDetails1({
    Key? key,
    required this.jobTitle,
    required this.firmname,
    required this.companywebsite,
    required this.companyImage
  }) : super(key: key);

  @override
  _CompanyDetails1State createState() => _CompanyDetails1State();
}

class _CompanyDetails1State extends State<CompanyDetails1> {
  bool _isApplied = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            CircleAvatar(
                    radius: 60,
  backgroundImage: NetworkImage('${ApiServices.baseUrl2}${widget.companyImage}'),
),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.jobTitle,
                  style: AppTextStyle.firmHead,
                ),
                Text(
                  widget.firmname, // Replace with actual company name
                  style: AppTextStyle.googletext,
                )
              ],
            ),
          ],
        ),
        SizedBox(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "About Company",
                  style: AppTextStyle.abouttxt,
                ),
              ),
              Text(
                jobDetailsResponse['companyDetails']?['about_company'] ??
                    "", // Replace with actual about info
                style: AppTextStyle.normaltxt,
                softWrap: true,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Visit - ${jobDetailsResponse['companyDetails']?['company_website'] ?? ''}",
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isApplied = true;
            });
          },
          child: Container(
            height: 60,
            width: 220,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: _isApplied ? green : green,
            ),
            child: Center(
              child: Text(
                _isApplied ? "Applied" : "Apply for this job",
                style: AppTextStyle.applytxt,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
