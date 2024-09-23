import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

class overViewCards extends StatelessWidget {
  const overViewCards({super.key});

  @override
  Widget build(BuildContext context) {
    // List of card data
    final List<Map<String, String>> cardData = [
      {
        'title': "Positioned",
        'subTitle': "Company position on this month",
      },
      {
        'title': "82 K",
        'subTitle': "Applicants applied on this month",
      },
      {
        'title': "30 K",
        'subTitle': "Applicants have got jobs",
      },
      {
        'title': "82K",
        'subTitle': "Applicants applied on this month",
      },
      {
        'title': "65%",
        'subTitle': "More applicants have got Python jobs",
      },
    ];

    return Container(
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage(overViewBg),
          fit: BoxFit.cover,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
        child: Center(
          child: SizedBox(
            height: 100, // Define the height for horizontal scroll
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: cardData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Cards(
                    title: cardData[index]['title']!,
                    subTitle: cardData[index]['subTitle']!,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final String title;
  final String subTitle;
  const Cards({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      width: 180,
      decoration: ShapeDecoration(
        color: const Color(0xFFFDFDFD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyle.headertext),
          const Spacer(),
          Text(subTitle,
              textAlign: TextAlign.start, style: AppTextStyle.bodytext),
        ],
      ),
    );
  }
}