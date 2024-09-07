
import 'package:flutter/material.dart';

class JobDetails extends StatelessWidget {
  final String jobTitle;
  final String jobSummary;
  final String expLevel;
  final String jobMode;
  final String jobType;
  final List<String> keyResponsibilities;

  const JobDetails({
    Key? key,
    required this.jobTitle,
    required this.jobSummary,
    required this.expLevel,
    required this.jobMode,
    required this.jobType,
    required this.keyResponsibilities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(jobTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(jobSummary),
            const SizedBox(height: 16),
            Text('Experience Level: $expLevel'),
            Text('Job Mode: $jobMode'),
            Text('Job Type: $jobType'),
            const SizedBox(height: 16),
            Text('Key Responsibilities:'),
            ...keyResponsibilities.map((resp) => Text('- $resp')),
          ],
        ),
      ),
    );
  }
}


