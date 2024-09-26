import 'package:flutter/material.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/showAll_bTn.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Repeating List Item
          _buildListItem(
              'name', 'Lorem ipsum dolor sit amet consectetur.', 'date'),
          const SizedBox(height: 8),
          _buildListItem(
              'name', 'Lorem ipsum dolor sit amet consectetur.', 'date'),
          const SizedBox(height: 8),
          _buildListItem(
              'name', 'Lorem ipsum dolor sit amet consectetur.', 'date'),
          const SizedBox(height: 16),
          // Show All Button
          ShowAllBtn(onTap: () {})
        ],
      ),
    );
  }

  // List Item Widget
  Widget _buildListItem(String name, String description, String date) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey[300], // Placeholder color for avatar
          child: Icon(Icons.person, color: Colors.grey[700]),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(description),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Text(date, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
