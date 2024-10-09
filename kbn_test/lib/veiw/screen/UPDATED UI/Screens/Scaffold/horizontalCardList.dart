import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/modelClass.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

class OverViewCards extends StatefulWidget {
  // final List<Map<String, String>> cardData; // Accept the dynamic data

  const OverViewCards({
    super.key,
  });

  @override
  State<OverViewCards> createState() => _OverViewCardsState();
}

class _OverViewCardsState extends State<OverViewCards> {
  Apiresponse? companyData; // To hold the API response
  bool isLoading = true; // To manage the loading state
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // Function to fetch data from API
  void _fetchData() async {
    try {
      Apiresponse response = await ApiServices.companyData();
      setState(() {
        companyData = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // List of card data
    final companyCommonData = companyData?.companyData.commonData;
    final int applicantGrowth =
        (companyCommonData?.applicantsTotal.thisMonth ?? 0) -
            (companyCommonData?.applicantsTotal.prevMonth ?? 0);

    final List<Map<String, String>> cardData = companyCommonData != null
        ? [
            {
              'title': companyCommonData.companyPosition.toString(),
              'subTitle': "Company position on this month",
            },
            {
              'title': companyCommonData.applicantsTotal.thisMonth.toString(),
              'subTitle': "Applicants applied this month",
            },
            {
              'title':
                  companyCommonData.applicantsSelected.thisMonth.toString(),
              'subTitle': "Applicants have got jobs",
            },
            {
              'title': "${companyCommonData.mostAppliedJob.growth.toString()}%",
              'subTitle':
                  "Applicants applied for ${companyCommonData.mostAppliedJob.title}",
            },
            {
              'title': applicantGrowth.toString(),
              'subTitle':
                  "Growth in ${companyCommonData.mostAppliedJob.title} jobs",
            },
          ]
        : [];

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
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
                    // physics: const NeverScrollableScrollPhysics(),
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
          Text(title, style: AppTextStyle.thirty_w500),
          const Spacer(),
          Text(subTitle,
              textAlign: TextAlign.start, style: AppTextStyle.bodytext_12),
        ],
      ),
    );
  }
}
