import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/date.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/view/screen/userScreen/home.dart';
import 'package:kbn_test/view/screen/userScreen/userT_n_C.dart';
import 'package:kbn_test/view/screen/userScreen/userWidgets/jobSummery.dart';
import 'package:kbn_test/view/widgets_common/goBack.dart';
import 'package:kbn_test/view/widgets_common/home_appbar_box.dart';

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
  final String status;
  final String about;
  final Map<String, dynamic> jobReq;

  const JobDetails(
      {super.key,
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
      required this.status,
      required this.about,
      required this.jobReq});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  bool _isApplied = false;
  String _currentStatus =
      ""; // Initialize a variable to hold the dynamic status

  @override
  void initState() {
    super.initState();
    // Set the initial status from widget
    _currentStatus = widget.status;
  }

  Future<void> _applyForJob() async {
    try {
      // Call the API to apply for the job
      final result = await ApiServices.applyForJob(widget.jobId);

      // Print the response to check its structure
      print('API Response: $result');

      // Check if the response has a 'message' field with "Application Created"
      if (result['message'] == 'Application Created') {
        setState(() {
          _isApplied = true;
          _currentStatus = 'Submitted'; // Update status to "Submitted"
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application successfully submitted!')),
        );
      } else {
        // Handle unexpected messages or error cases
        setState(() {
          _isApplied = false;
          _currentStatus = widget.status; // Revert to the original status
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to apply: ${result['message']}')),
        );
      }
    } catch (e) {
      // Revert the state if an error occurred
      setState(() {
        _isApplied = false;
        _currentStatus = widget.status; // Revert to original status on error
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool canApply = _currentStatus == "Apply for this Job";

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  width: size.width * 1,
                  child: Column(
                    children: [
                      const Center(child: Image(image: AssetImage(kbnLogo))),
                      HomeAppBarBox(context,
                          T_and_C: const user_T_n_C(),
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
                                child: size.width < 1200
                                    ?

                                    //////////web view of colum 1///////////

                                    SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: size.width < 1200
                                                  ? size.width * 1
                                                  : size.width * 0.4,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: CompanyDetails1(
                                                  jobId: widget.jobId,
                                                  aboutCompany:
                                                      widget.about,
                                                  userId: widget.companyId,
                                                  jobTitle: widget.jobTitle,
                                                  firmname: widget.firmname,
                                                  status: widget.status,
                                                  companywebsite:
                                                      widget.companywebsite,
                                                  companyImage:
                                                      widget.companyImage,
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 25),
                                              child:
                                                  Divider(color: shadowblack),
                                            ),
                                            CompanyDetails2(size),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 25),
                                              child: Divider(
                                                color: shadowblack,
                                              ),
                                            ),
                                            CompanyDetails3(size),
                                            GestureDetector(
                                                onTap: canApply
                                                    ? _applyForJob
                                                    : null, // Disable if can't apply
                                                child: size.width < 1200
                                                    ? Container(
                                                        height: 60,
                                                        width: 220,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12)),
                                                          color: getStatusColor(
                                                              _currentStatus), // Use dynamic status color
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            _currentStatus, // Display dynamic status
                                                            style: AppTextStyle
                                                                .normalW500
                                                                .copyWith(
                                                                    color:
                                                                        white),
                                                          ),
                                                        ),
                                                      )
                                                    : Container()),
                                          ],
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.4,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: CompanyDetails1(
                                                jobId: widget.jobId,
                                                aboutCompany: widget.about,
                                                userId: widget.companyId,
                                                jobTitle: widget.jobTitle,
                                                firmname: widget.firmname,
                                                status: widget.status,
                                                companywebsite:
                                                    widget.companywebsite,
                                                companyImage:
                                                    widget.companyImage,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 25),
                                            child: VerticalDivider(
                                                color: shadowblack),
                                          ),
                                          CompanyDetails2(size),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 25),
                                            child: VerticalDivider(
                                                color: shadowblack),
                                          ),
                                          CompanyDetails3(size),
                                        ],
                                      ),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, right: 5),
                                    child: Text(
                                        calculateDaysAgo(widget.datePosted)),
                                  ))
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
          GoBack(context, homePage: const UserHome())
        ],
      ),
    );
  }

  Padding CompanyDetails3(Size size) {
    Map<String, dynamic> reqlist = widget.jobReq;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        // width: size.width * .25,
        width: size.width < 1200 ? size.width * 1 : size.width * 0.22,

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Job Requirements",
                  style: AppTextStyle.thirteenW500,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "• Skills:",
                      style: AppTextStyle.twelve_w500,
                    ),
                  ),
                  ...reqlist['skills'].first.split(',').map((skill) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "-" +
                                  "\t" * 3 +
                                  skill
                                      .trim(), // Use `trim` to remove any leading/trailing spaces
                              style: AppTextStyle.normalText,
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "• Experience:",
                      style: AppTextStyle.twelve_w500,
                    ),
                  ),
                  ...reqlist['experience'].first.split(',').map((exp) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "-" + "\t" * 3 + exp.trim(),
                              style: AppTextStyle.normalText,
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "• Educational Background:",
                      style: AppTextStyle.twelve_w500,
                    ),
                  ),
                  ...reqlist['educational_background']
                      .first
                      .split(",")
                      .map((edu) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  "-" + "\t" * 3 + edu.trim(),
                                  style: AppTextStyle.normalText,
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
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          // width: size.width * .25,
          width: size.width < 1200 ? size.width * 1 : size.width * 0.22,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Job Summary",
                  style: AppTextStyle.thirteenW500,
                ),
              ),
              Text(
                widget.jobSummary,
                style: AppTextStyle.normalText,
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
              JobSummaryWid(jobicon: clockPng, txt: widget.jobType),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: SizedBox(
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Key Responsibilities:",
                          style: AppTextStyle.thirteenW500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      for (var item in widget.keyResponsibilities.first
                          .split(',')) // Split the string by commas
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  "-" +
                                      "\t" * 3 +
                                      item.trim(), // Trim to remove any leading/trailing spaces
                                  style: AppTextStyle.normalText,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// Import ApiServices

class CompanyDetails1 extends StatefulWidget {
  final String jobTitle;
  final String firmname;
  final String companywebsite;
  final String aboutCompany;
  final String companyImage;
  final String status;
  final int jobId; // jobId
  final int userId; // userId

  const CompanyDetails1({
    super.key,
    required this.jobTitle,
    required this.firmname,
    required this.companywebsite,
    required this.companyImage,
    required this.aboutCompany,
    required this.jobId,
    required this.userId,
    required this.status,
  });

  @override
  _CompanyDetails1State createState() => _CompanyDetails1State();
}

class _CompanyDetails1State extends State<CompanyDetails1> {
  bool _isApplied = false;
  String _currentStatus =
      ""; // Initialize a variable to hold the dynamic status

  @override
  void initState() {
    super.initState();
    // Set the initial status from widget
    _currentStatus = widget.status;
  }

  Future<void> _applyForJob() async {
    try {
      // Call the API to apply for the job
      final result = await ApiServices.applyForJob(widget.jobId);

      // Print the response to check its structure
      print('API Response: $result');

      // Check if the response has a 'message' field with "Application Created"
      if (result['message'] == 'Application Created') {
        setState(() {
          _isApplied = true;
          _currentStatus = 'SUBMITTED'; // Update status to "Submitted"
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application successfully submitted!')),
        );
      } else {
        // Handle unexpected messages or error cases
        setState(() {
          _isApplied = false;
          _currentStatus = widget.status; // Revert to the original status
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to apply: ${result['message']}')),
        );
      }
    } catch (e) {
      // Revert the state if an error occurred
      setState(() {
        _isApplied = false;
        _currentStatus = widget.status; // Revert to original status on error
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if the job can be applied for by comparing the current status
    bool canApply = _currentStatus == "Apply for this Job";
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  NetworkImage('${ApiServices.baseUrl}${widget.companyImage}'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.jobTitle,
                  style: AppTextStyle.twntyFive_W600,
                ),
                Text(
                  widget.firmname,
                  style: AppTextStyle.twentyW400,
                ),
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
                  style: AppTextStyle.thirteenW500,
                ),
              ),
              Text(
                widget.aboutCompany,
                style: AppTextStyle.normalText,
                softWrap: true,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Visit - ${widget.companywebsite}",
                ),
              ),
            ],
          ),
        ),
        // In CompanyDetails1
        GestureDetector(
          onTap: canApply ? _applyForJob : null, // Disable if can't apply
          child: size.width < 1200
              ? Container()
              : Container(
                  height: 60,
                  width: 220,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: getStatusColor(
                        _currentStatus), // Use dynamic status color
                  ),
                  child: Center(
                    child: Text(
                      _currentStatus, // Display dynamic status
                      style: AppTextStyle.normalW500.copyWith(
                        color: white,
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
