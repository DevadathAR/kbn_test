
import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/service/api_service.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/text_style.dart';

class LatestJobCard extends StatefulWidget {
  final String jobTitle;
  final String jobSummary;
  final String firmname;
  final String expLevel;
  final String jobMode;
  final String jobType;
  final String companyImage;
  final String datePosted;
  final String status;

  LatestJobCard({
    required this.jobTitle,
    required this.jobSummary,
    required this.expLevel,
    required this.firmname,
    required this.jobMode,
    required this.jobType,
    required this.companyImage,
    required this.datePosted,
    required this.status,
  });

  @override
  _LatestJobCardState createState() => _LatestJobCardState();
}

class _LatestJobCardState extends State<LatestJobCard> {
  bool _isApplied = false;

  String calculateDaysAgo(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;

    if (days > 0) {
      return 'posted $days days ago';
    } else if (hours > 0) {
      return 'posted $hours hours ago';
    } else if (minutes > 0) {
      return 'posted $minutes minutes ago';
    } else {
      return 'posted just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 20, left: 10),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: black,
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage('$baseUrl2${widget.companyImage}'),
                  ),
                  Column(
                    children: [
                      Text(
                        widget.jobTitle,
                        style: AppTextStyle.postheadtxt,
                      ),
                      Text(
                        widget.firmname,
                        style: AppTextStyle.tactext,
                      ),
                    ],
                  ),
                  const Image(
                    image: AssetImage(likePng),
                    color: black,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.jobSummary,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Requirments(txt: widget.expLevel),
                Requirments(txt: widget.jobMode),
                Requirments(txt: widget.jobType),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: getStatusColor(widget.status),
                    ),
                    child: Center(
                      child: Text(
                        widget.status,
                        style: AppTextStyle.applytxt.copyWith(color: getTxtColor(widget.status)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Image(image: AssetImage(clockPng)),
                      ),
                      Text(calculateDaysAgo(widget.datePosted))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget Requirments({required String txt}) {
  return Container(
    height: 20,
    width: 90,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      color: green,
    ),
    child: Center(
        child: Text(
      txt,
      style: AppTextStyle.buttontxt,
    )),
  );
}