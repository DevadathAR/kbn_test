import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/applicantsScreen.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/jobScreen.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/messageScreen.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/companyHome.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/profileScreen.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/settingsScreen.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/statisticScreen.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/termsNconditions.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/transactionScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sidebar extends StatefulWidget {
  final String currentPath;
  const Sidebar({super.key, required this.currentPath});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10),
      color: white,
      constraints: const BoxConstraints(
        minWidth: 80,
        maxWidth: 180, // Maximum width for the ListView
      ),
      child: Column(
        children: [
          // KBN LOGO
          Container(
            padding: const EdgeInsets.all(16),
            height: 50,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(kbnLogo),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 100),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("MENU", style: AppTextStyle.fourteenW400),
                ),
                const SizedBox(height: 10),
                _buildListTile(
                  icon: Icons.home,
                  label: 'Overview',
                  path: 'Overview',
                  onTap: () {
                    if (widget.currentPath != "Overview") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CompanyHome()));
                    } else {}
                  },
                ),
                _buildListTile(
                  icon: Icons.show_chart,
                  label: 'Statistics',
                  path: 'Statistics',
                  onTap: () {
                    if (widget.currentPath != "Statistics") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CompanyStatisticScreen()));
                    }
                  },
                ),
                _buildListTile(
                  path: "Applicants",
                  icon: Icons.people_outline,
                  label: isCompany ? 'Applicants' : 'Companies',
                  onTap: () {
                    if (widget.currentPath != "Applicants") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CompanyApplicantScreen()));
                    }
                  },
                ),
                if (isCompany)
                  _buildListTile(
                    path: "Jobs",
                    icon: Icons.wallet_rounded,
                    label: 'Jobs',
                    onTap: () {
                      if (widget.currentPath != "Jobs") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CompanyJobpage()));
                      }
                    },
                  ),
                _buildListTile(
                  path: "Messages",
                  icon: Icons.notifications,
                  label: 'Messages',
                  onTap: () {
                    if (widget.currentPath != "Messages") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CompanyMessage()));
                    }
                  },
                ),
                _buildListTile(
                  path: "Transactions",
                  icon: Icons.credit_card_sharp,
                  label: 'Transactions',
                  onTap: () {
                    if (widget.currentPath != "Transactions") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CompanyTransation(),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const Divider(indent: 16, endIndent: 16),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text("GENERAL", style: AppTextStyle.fourteenW400),
          ),
          const SizedBox(height: 10),
          _buildListTile(
            path: "Settings",
            icon: Icons.settings,
            label: 'Settings',
            onTap: () {
              if (widget.currentPath != "Settings") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CompanySettingPage()));
              }
            },
          ),
          _buildListTile(
            path: "Terms",
            icon: Icons.library_books_outlined,
            label: 'Terms',
            onTap: () {
              if (widget.currentPath != "Terms") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TermsNconditions()));
              }
            },
          ),
          profileButton(
            context: context, // Pass the context from the widget tree
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CompanyProfileScreen()));
            },
          ),
        ],
      ),
    );
  }

  Widget profileButton({
    required BuildContext context,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: tealblue,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Image.asset(
                    color: white,
                    personPng,
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Name",
                    style: AppTextStyle.bodytextwhite,
                  ),
                ],
              ),
              GestureDetector(
                child: Image.asset(width: 15, height: 15, logOutPng),
                onTap: () {
                  showLogoutConfirmation(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildListTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required String path,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(100), topLeft: Radius.circular(100)),
          color: path == widget.currentPath ? textGrey : null),
      child: ListTile(
        // tileColor: Colors.amber,
        selected: path == widget.currentPath,
        // selectedTileColor: path == widget.currentPath ? Colors.red : black,
        leading: Icon(
          icon,
          color: path == widget.currentPath
              ? tealblue
              : black, // Change the icon color if selected
        ),
        title: Text(label, style: AppTextStyle.bodytext_12),
        onTap: onTap,
      ),
    );
  }
}

void showLogoutConfirmation(BuildContext context) {
  void onLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear the login status
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CompanyLoginPage()),
    );
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
                  color: white,
                  border: Border.all(color: white, width: 2),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 35),
                      child: Text(
                        "Do you want to logout?",
                        style: AppTextStyle.sixteen_w500,
                      ),
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
                              side: BorderSide(color: black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          child: const Text(
                            "Logout",
                            style: AppTextStyle.twentyW400,
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
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CompanyHome()),
                    );
                  },
                  child: const Text(
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
