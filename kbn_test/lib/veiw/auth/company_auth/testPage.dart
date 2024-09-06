import 'package:flutter/material.dart';

class TestPAge extends StatelessWidget {
  final Map<String, dynamic> userDetails;

  const TestPAge({super.key, required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${userDetails['name']}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${userDetails['name']}"),
            Text("Email: ${userDetails['email']}"),
            Text("Contact: ${userDetails['contact'] ?? 'N/A'}"),
            Text("Address: ${userDetails['address'] ?? 'N/A'}"),
            // Add more fields as needed
            Image.network(
              'http://192.168.29.37:8000${userDetails['profile_image']}',
              errorBuilder: (context, error, stackTrace) {
                return const Text('Failed to load image');
              },
            ),
          ],
        ),
      ),
    );
  }
}
