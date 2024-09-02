import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/home.dart';
import 'package:kbn_test/veiw/screen/informationpage.dart';
import 'package:kbn_test/veiw/screen/profilePage.dart';

Widget SideNavBar(
  context, {
  viewhome,viewinfo,viewprof
}) {
  Size size = MediaQuery.of(context).size;

  return Container(
    height: size.height * 1,
    width: 230,
    color: sidebarWhite,
    child: Stack(
      children: [
        const Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                height: 590,
                width: 230,
                child: Image(fit: BoxFit.fill, image: AssetImage(sideBarPng)))),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(image: AssetImage(logoPng)),
              const Text(
                logoName,
                style: AppTextStyle.logoNameText,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  hi,
                  style: AppTextStyle.subheadertext,
                ),
              ),
              const Text(
                "User",
                style: AppTextStyle.subheadertext,
              ),
              SideBarNavIteam(context,
                  navicon: findJobPng,
                  navtxt: findJob,
                  nextpage: Home(),
                  viewcolor: viewhome),
              SideBarNavIteam(context,
                  navicon: informationPng,
                  navtxt: info,viewcolor: viewinfo,
                  nextpage: Informationpage()),
              SideBarNavIteam(context,
                  navicon: profilePng,
                  viewcolor: viewprof,
                  navtxt: profile,
                  nextpage: ProfilePage()),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget SideBarNavIteam(BuildContext context,
    {navicon, navtxt, nextpage, viewcolor = none}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 50),
    child: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return nextpage;
          },
        ));
      },
      child: Row(
        children: [
          Container(
            height: 80,
            width: 10,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    topRight: Radius.circular(12)),
                color: viewcolor),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Image(image: AssetImage(navicon)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              navtxt,
              style: AppTextStyle.sideBarTxt,
            ),
          )
        ],
      ),
    ),
  );
}
