import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kbn_test/UPDATED%20UI/Screens/applicantsScreen.dart';
import 'package:kbn_test/UPDATED%20UI/Screens/jobScreen.dart';
import 'package:kbn_test/UPDATED%20UI/Screens/overView.dart';
import 'package:kbn_test/UPDATED%20UI/Screens/profileScreen.dart';
import 'package:kbn_test/UPDATED%20UI/Screens/settingsScreen.dart';
import 'package:kbn_test/UPDATED%20UI/Screens/statisticScreen.dart';
import 'package:kbn_test/UPDATED%20UI/Screens/transactionScreen.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/companyScreen/companyProfile.dart';

import '../Screens/messageScreen.dart';

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
      padding: const EdgeInsets.only(top: 20, bottom: 10),
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
              padding: const EdgeInsets.all(5),
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("MENU", style: AppTextStyle.tactext),
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
                              builder: (context) => const Home()));
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
                              builder: (context) => const StatisticScreen()));
                    }
                  },
                ),
                _buildListTile(
                  path: "Applicants",
                  icon: Icons.people_outline,
                  label: 'Applicants',
                  onTap: () {
                    if (widget.currentPath != "Applicants") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TwoTablesScreen()));
                    }
                  },
                ),
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
            child: Text("GENERAL", style: AppTextStyle.tactext),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
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
                path: "",
                icon: Icons.library_books_outlined,
                label: 'Terms',
                onTap: () {},
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
          )
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
              Image.asset(width: 15, height: 15, logOutPng)
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for ListTile
  ListTile _buildListTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required String path,
  }) {
    return ListTile(
      // tileColor: Colors.amber,
      selected: path == widget.currentPath,
      // selectedTileColor: path == widget.currentPath ? Colors.red : black,
      leading: Icon(
        icon,
        color: path == widget.currentPath
            ? tealblue
            : black, // Change the icon color if selected
      ),
      title: Text(label, style: AppTextStyle.bodytext),
      onTap: onTap,
    );
  }
}
