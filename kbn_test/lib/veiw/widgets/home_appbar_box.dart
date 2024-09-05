import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/company_auth/cmpny_login.dart';
import 'package:kbn_test/veiw/screen/companyScreen/T_&_C.dart';
import 'package:kbn_test/veiw/screen/companyScreen/cmpny_home.dart';
import 'package:kbn_test/veiw/screen/companyScreen/companyProfile.dart';
import 'package:kbn_test/veiw/screen/userScreen/home.dart';

Widget HomeAppBarBox(context, {T_and_C, logOutTo}) {
  return Container(
    height: 80,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(2)),
      color: tealblue,
    ),
    width: double.infinity, // Makes the container fill the width of the screen
    child: Row(
      children: [
        const Spacer(),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            firmName,
            style: AppTextStyle.hoomeSubhead,
          ),
        ),
        const Spacer(), // Pushes the buttons to the right side
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            children: [
              // terms and conditions
              AppBarButtons(
                context,
                icon: termsPng,
                nextPage: T_and_C,
                iconcolor: Colors.transparent,
              ),
              const SizedBox(width: 20), // Space between buttons
              // profilePage
              AppBarButtons(context,
                  icon: unknownPng, nextPage: const CompanyProfilePage()),
              const SizedBox(width: 20), // Space between buttons
              //LogOut
              AppBarButtons(
                context,
                icon: logOutPng,
                nextPage: logOutTo,
                iconcolor: Colors.transparent,
                isLogout: true,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget AppBarButtons(BuildContext context,
    {required String icon,
    required Widget nextPage,
    Color? iconcolor,
    bool isLogout = false}) {
  return TextButton(
      onPressed: () {
        if (isLogout) {
          showLogoutConfirmation(context);
        } else {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return nextPage;
            },
          ));
        }
      },
      child: Image(
        image: AssetImage(icon),
        color: iconcolor,
      ));
}

void showLogoutConfirmation(BuildContext context) {
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
                    border: Border.all(color: white, width: 2)),
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
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return const CompanyLoginPage(); // Navigate to the login page
                              },
                            ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const UserHome();
                        }));
                      },
                      child: Text(
                        "Back to home",
                        style: AppTextStyle.bodytextwhiteunderline,
                      )))
            ],
          )
        ],
      );
    },
  );
}
