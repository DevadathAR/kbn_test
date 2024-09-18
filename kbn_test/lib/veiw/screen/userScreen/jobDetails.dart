import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/user_auth/userLogin.dart';
import 'package:kbn_test/veiw/screen/userScreen/userT_n_C.dart';
import 'package:kbn_test/veiw/widgets/home_appbar_box.dart';
import 'package:kbn_test/veiw/widgets/jobSummery.dart';

class JobDetails extends StatelessWidget {
  const JobDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          // SideNavBar(context, viewhome: black),
          SingleChildScrollView(
            child: SizedBox(
              width: size.width * 1,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Image(image: AssetImage(kbnLogo))),
                  HomeAppBarBox(
                    context,
                    T_and_C: const user_T_n_C(),
                    // logOutTo: const UserLoginPage(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                              offset: Offset(1, 1)),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: white,
                      ),

                      ////////row seperation
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ////logo , name and about of firm
                          SizedBox(
                            // color: tealblue,
                            width: size.width * 0.4,
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: JobDetails1(),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: VerticalDivider(
                              color: shadowblack,
                            ),
                          ),
                          CompanyDetails2(size),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: VerticalDivider(
                              color: shadowblack,
                            ),
                          ),
                          CompanyDetails3(size),
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
    const String req =
        "Responsibility 1, Responsibility 2, Responsibility 3, Responsibility 4,Responsibility 2, Responsibility 3, Responsibility ,4Responsibility 2, Responsibility 3, Responsibility 4";
    List<String> reqlist = req.split(',');
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SizedBox(
          width: size.width * .25,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Job Requirements",
                  style: AppTextStyle.abouttxt,
                ),
              ),
              const SizedBox(height: 10),
              // Display the responsibilities as a bullet-pointed list
              for (var item in reqlist)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '• ', // Bullet point
                        style: TextStyle(fontSize: 20),
                      ),
                      Expanded(
                        child: Text(
                          item.trim(),
                          style: AppTextStyle.normalText,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView CompanyDetails2(Size size) {
    // Example data, replace with actual data from your JSON response
    const String respon =
        "Responsibility 1, Responsibility 2, Responsibility 3, Responsibility 4,Responsibility 2, Responsibility 3, Responsibility ,4Responsibility 2, Responsibility 3, Responsibility 4";
    List<String> responList = respon.split(','); // Convert the string to a list

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SizedBox(
          width: size.width * .25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Job Summary",
                  style: AppTextStyle.abouttxt,
                ),
              ),
              const Text(
                summry,
                style: AppTextStyle.normalText,
                softWrap: true,
              ),
              JobSummaryWid(jobicon: bagPng, txt: "level"),
              JobSummaryWid(jobicon: vacancyPng, txt: "vacancy"),
              JobSummaryWid(jobicon: locattionPng, txt: "location"),
              JobSummaryWid(jobicon: salaryPng, txt: "salary"),
              JobSummaryWid(jobicon: clockPng, txt: "full time"),
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
                    // Display the responsibilities as a bullet-pointed list
                    for (var item in responList)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '• ', // Bullet point
                              style: TextStyle(fontSize: 20),
                            ),
                            Expanded(
                              child: Text(
                                item.trim(),
                                style: AppTextStyle.normalText,
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

class JobDetails1 extends StatefulWidget {
  const JobDetails1({super.key});

  @override
  _JobDetails1State createState() => _JobDetails1State();
}

class _JobDetails1State extends State<JobDetails1> {
  bool _isApplied = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Row(
          children: [
            Image(
              image: AssetImage(unknownPng),
              color: green,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "position",
                  style: AppTextStyle.firmHead,
                ),
                Text(
                  "company",
                  style: AppTextStyle.googletext,
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "About Company  ",
                  style: AppTextStyle.abouttxt,
                ),
              ),
              Text(
                aboutcomp,
                style: AppTextStyle.normalText,
                softWrap: true,
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Visit - ${"site"}",
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isApplied = true; // set to true only once
            });
          },
          child: Container(
            height: 60,
            width: 220,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: _isApplied
                  ? green
                  : green, // update the color based on the state
            ),
            child: Center(
              child: Text(
                _isApplied
                    ? "Applied"
                    : "Apply for this job", // update the text based on the state
                style: AppTextStyle.applytxt,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
