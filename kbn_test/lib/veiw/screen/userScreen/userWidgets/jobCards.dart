import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/colors.dart';
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

  const LatestJobCard({
    super.key,
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
  final bool _isApplied = false;

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
    Size size = MediaQuery.of(context).size;

    double getHeight(double screenWidth) {
      if (screenWidth < 900) {
        return screenWidth * 0.1; // 12% of screen width for small screens
      } else if (screenWidth < 1200) {
        return screenWidth * 0.06; // 15% of screen width for medium screens
      } else if (screenWidth < 1600) {
        return screenWidth * 0.045; // 18% of screen width for large screens
      } else {
        return screenWidth * 0.03; // or any other default value
      }
    }

    double getWidth(double screenWidth) {
      if (screenWidth < 900) {
        return screenWidth * 0.25; // 25% of screen width for small screens
      } else if (screenWidth < 1200) {
        return screenWidth * 0.12; // 40% of screen width for medium screens
      } else if (screenWidth < 1600) {
        return screenWidth * 0.08; // 50% of screen width for large screens
      } else {
        return screenWidth * 0.06; // or any other default value
      }
    }

    double getLogoRadius(double screenWidth) {
      if (screenWidth < 900) {
        return 40; // larger radius for small screens
      } else {
        return 25; // default radius for larger screens
      }
    }

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
                    radius: getLogoRadius(size.width),
                    backgroundImage: NetworkImage(
                        '${ApiServices.baseUrl}${widget.companyImage}'),
                  ),
                  Column(
                    children: [
                      Text(
                        widget.jobTitle,
                        style: AppTextStyle.sixteen_w500,
                      ),
                      Text(
                        widget.firmname,
                        style: AppTextStyle.fourteenW400,
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
                Requirments(context, txt: widget.expLevel),
                Requirments(context, txt: widget.jobMode),
                Requirments(context, txt: widget.jobType),
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
                  // SubmitButton..........
                  Container(
                    height: getHeight(size.width),
                    width: getWidth(size.width),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: getStatusColor(widget.status),
                    ),
                    child: Center(
                      child: Text(
                        widget.status,
                        style: AppTextStyle.normalW500
                            .copyWith(color: getTxtColor(widget.status)),
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

Widget Requirments(context, {required String txt}) {
  Size size = MediaQuery.of(context).size;
  double containerWidth;

  if (size.width < 900) {
    containerWidth = size.width * 0.25;
  } else if (size.width < 1200) {
    containerWidth = size.width * 0.1;
  } else if (size.width < 1600) {
    containerWidth = size.width * 0.075;
  } else {
    containerWidth = size.width * 0.05; // or any other default value
  }

  return Container(
    height: 25,
    width: containerWidth,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      color: green,
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          txt,
          style: AppTextStyle.buttontxt,
        ),
      ),
    ),
  );
}
