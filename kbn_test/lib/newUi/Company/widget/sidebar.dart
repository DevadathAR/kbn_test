import 'package:flutter/material.dart';
import 'package:kbn_test/newUi/Company/view/CompanyMessage.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

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
                    // if (widget.currentPath != "Overview") {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const Home()));
                    // } else {}
                  },
                ),
                _buildListTile(
                  icon: Icons.show_chart,
                  label: 'Statistics',
                  path: 'Statistics',
                  onTap: () {
                    // if (widget.currentPath != "Statistics") {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const StatisticScreen()));
                    // }
                  },
                ),
                _buildListTile(
                  path: "",
                  icon: Icons.people_outline,
                  label: 'Applicants',
                  onTap: () {},
                ),
                _buildListTile(
                  path: "",
                  icon: Icons.wallet_rounded,
                  label: 'Jobs',
                  onTap: () {},
                ),
                _buildListTile(
                  path: "Message",
                  icon: Icons.notifications,
                  label: 'Messages',
                  onTap: () {
                    if (widget.currentPath != "Message") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CompanyMessage()));
                    }
                  },
                ),
                _buildListTile(
                  path: "",
                  icon: Icons.credit_card_sharp,
                  label: 'Transactions',
                  onTap: () {},
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
          _buildListTile(
            path: "",
            icon: Icons.settings,
            label: 'Settings',
            onTap: () {},
          ),
          _buildListTile(
            path: "",
            icon: Icons.library_books_outlined,
            label: 'Terms',
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
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
          )
        ],
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
      tileColor: Colors.amber,
      selected: path == widget.currentPath,
      selectedTileColor: Colors.red,
      leading: Icon(
        icon,
        color: path == widget.currentPath
            ? Colors.blue
            : black, // Change the icon color if selected
      ),
      title: Text(label, style: AppTextStyle.bodytext),
      onTap: onTap,
    );
  }
}
