import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/company_auth/cmpny_login.dart';
import 'package:kbn_test/veiw/auth/user_auth/userLogin.dart';
import 'package:kbn_test/veiw/screen/userScreen/jobDetails.dart';
import 'package:kbn_test/veiw/screen/userScreen/userT_n_C.dart';
import 'package:kbn_test/veiw/widgets/home_appbar_box.dart';
import 'package:kbn_test/veiw/widgets/home_filter_box.dart';

class UserHome extends StatelessWidget {
  const UserHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              width: size.width * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Image(image: AssetImage(kbnLogo))),
                  HomeAppBarBox(context,
                      T_and_C: const user_T_n_C(),
                      profileImage:
                          "${ApiServices.baseUrl}/${userDetails['user']['profile_image']}",
                      logOutTo: const UserLoginPage()),
                  const SizedBox(
                    height: 10,
                  ),
                  HomeFilterBox(context),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Text(
                      latestjob,
                      style: AppTextStyle.tactexthead,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: SizedBox(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 261 / 190),
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const JobDetails();
                                    },
                                  ));
                                },
                                child: const LatestJobCard());
                          },
                        ),
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
}

class LatestJobCard extends StatefulWidget {
  const LatestJobCard({super.key});

  @override
  _LatestJobCardState createState() => _LatestJobCardState();
}

class _LatestJobCardState extends State<LatestJobCard> {
  bool _isApplied = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 20, left: 10),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: black,
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image(
                    image: AssetImage(unknownPng),
                    color: green,
                  ),
                  Column(
                    children: [
                      Text(
                        "position",
                        style: AppTextStyle.postheadtxt,
                      ),
                      Text(
                        "name",
                        style: AppTextStyle.tactext,
                      ),
                    ],
                  ),
                  Image(
                    image: AssetImage(likePng),
                    color: black,
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                cardcontent, maxLines: 3, // Limit the text to 3 lines
                overflow: TextOverflow
                    .ellipsis, // Show ellipsis if the text exceeds 3 lines
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Requirments(txt: "Requirments 1"),
                Requirments(txt: "Requirments 2"),
                Requirments(txt: "Requirments 3"),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isApplied = true; // set to true only once
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Image(image: AssetImage(clockPng)),
                      ),
                      Text("posted X days ago")
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget Requirments({txt}) {
  return Container(
    height: 20,
    width: 90,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      color: green,
    ),
    child: Center(
        child: Text(
      txt,
      style: AppTextStyle.buttontxt,
    )),
  );
}
