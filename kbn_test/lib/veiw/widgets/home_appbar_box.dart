import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/user_auth/login.dart';
import 'package:kbn_test/veiw/screen/user_screen/home.dart';
import 'package:kbn_test/veiw/screen/user_screen/termsandcond_applicant.dart';
Widget HomeAppBarBox(context,
    {termsiconcolor, likeiconcolor, searchiconcolor}) {
  // Size size = MediaQuery.of(context).size;

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
              AppBarButtons(
                context,
                icon: termsPng,
                nextPage: const TaC(),
                iconcolor: termsiconcolor,
              ),
              const SizedBox(width: 20), // Space between buttons
              AppBarButtons(
                context,
                icon: unknownPng,
                nextPage: const Home(),
              ),
              const SizedBox(width: 20), // Space between buttons
              AppBarButtons(
                context,
                icon: logOutPng,
                nextPage: const Home(),
                iconcolor: termsiconcolor,
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
        backgroundColor: none, // Set the background color to yellow
        
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
                      doYoyWantLogout,
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
                            logout,
                            style: AppTextStyle.googletext,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return const LogInPage(); // Navigate to the login page
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
                          return const Home();
                        }));
                      },
                      child: Text(
                        backtohome,
                        
                        style: AppTextStyle.bodytextwhiteunderline,
                      )))
            ],
          )
        ],
      );
    },
  );
}
