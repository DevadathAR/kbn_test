import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/company_auth/cmpny_login.dart';
import 'package:kbn_test/veiw/screen/companyScreen/cmpny_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget HomeAppBarBox(BuildContext context,
    {Widget? T_and_C,
    // Widget? logOutTo,
    Widget? profilePage,
    String? profileImage,
    Widget? home}) {
  Size size = MediaQuery.of(context).size;
  double screenWidth = size.width;

  return Container(
    height: screenWidth < 600 ? 60 : 80, // Adjust height based on screen size
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(2)),
      color: tealblue,
    ),
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05), // Responsive padding
      child: Row(
        children: [
          Text(
            firmName,
            style: AppTextStyle.hoomeSubhead
                .copyWith(fontSize: screenWidth < 600 ? 16 : 20),
          ),
          const Spacer(),
          Row(
            children: [
              //Terms and Conditions
              AppBarButtons(
                context,
                icon: termsPng,
                nextPage: T_and_C,
                iconcolor: Colors.transparent,
              ),
              SizedBox(width: screenWidth * 0.02),
              //profileButton
              AppBarButtons(context,
                  icon: unknownPng,
                  uploadedImage: profileImage,
                  nextPage: profilePage),
              SizedBox(width: screenWidth * 0.02),
              // LogOut
              AppBarButtons(context,
                  icon: logOutPng,
                  iconcolor: Colors.transparent,
                  isLogout: true,
                  logOutTo: const CompanyLoginPage(),
                  backHome: home),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget AppBarButtons(
  BuildContext context, {
  required String icon,
  String? uploadedImage,
  Widget? nextPage,
  Color? iconcolor,
  bool isLogout = false,
  Widget? logOutTo,
  Widget? backHome,
}) {
  Size size = MediaQuery.of(context).size;
  double screenWidth = size.width;

  return TextButton(
    onPressed: () {
      if (isLogout) {
        showLogoutConfirmation(context, logOutTo, backHome);
      } else {
        if (nextPage != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => nextPage));
        }
      }
    },
    child: uploadedImage != null
        ? CircleAvatar(
            backgroundImage: NetworkImage(uploadedImage),
            radius: screenWidth < 600 ? 15 : 20, // Adjust avatar size
          )
        : Image(
            image: AssetImage(icon),
            color: iconcolor,
            width: screenWidth < 600 ? 20 : 30, // Adjust icon size
          ),
  );
}

void showLogoutConfirmation(
    BuildContext context, Widget? logOutTo, Widget? backHome) {
  void onLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear the login status
    if (logOutTo != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => logOutTo),
      );
    }
  }

  showDialog(
    context: context,
    barrierColor: semitransp,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: none, // Set the background color to none
        actions: <Widget>[
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Ensure buttons stretch full width
            children: [
              Container(
                width: 500,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: none,
                  border: Border.all(color: white, width: 2),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Do you want to logout?",
                      style: AppTextStyle.flitertxt,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 50),
                      child: SizedBox(
                        width: 200, // Set the desired width
                        height: 60, // Set the desired height
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: black,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          child: const Text(
                            "Logout",
                            style: AppTextStyle.googletext,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            onLogout();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (backHome != null)
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => backHome),
                      );
                    },
                    child: Text(
                      "Back to home",
                      style: AppTextStyle.bodytextwhiteunderline,
                    ),
                  ),
                )
            ],
          )
        ],
      );
    },
  );
}
