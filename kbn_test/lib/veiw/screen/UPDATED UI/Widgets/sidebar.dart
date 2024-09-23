import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      color: white,
      constraints: const BoxConstraints(
        minWidth: 100,
        maxWidth: 200, // Maximum width for the ListView
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
                _buildListTile(
                  icon: Icons.home,
                  label: 'Overview',
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.show_chart,
                  label: 'Statistics',
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.people_outline,
                  label: 'Applicants',
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.wallet_rounded,
                  label: 'Jobs',
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.notifications,
                  label: 'Messages',
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.credit_card_sharp,
                  label: 'Transactions',
                  onTap: () {},
                ),
                // Additional menu items ...
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for ListTile
  ListTile _buildListTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: black),
      title: Text(label, style: const TextStyle(color: black)),
      onTap: onTap,
    );
  }
}
