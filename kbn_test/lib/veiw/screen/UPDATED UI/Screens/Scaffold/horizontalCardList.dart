import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/modelClass.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

class overViewCards extends StatefulWidget {
  // final List<Map<String, String>> cardData; // Accept the dynamic data

  const overViewCards({
    super.key,
  });

  @override
  State<overViewCards> createState() => _overViewCardsState();
}

class _overViewCardsState extends State<overViewCards> {
  Apiresponse? companyData; // To hold the API response
  bool isLoading = true; // To manage the loading state
  @override
  void initState() {
    // TODO: implement initState
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
    final List<Map<String, String>> cardData = companyData != null
        ? [
            {
              'title': companyData!.companyData.commonData.companyPosition
                  .toString(), // Added null check
              'subTitle': "Company position on this month",
            },
            {
              'title': companyData!
                  .companyData.commonData.applicantsTotal.thisMonth
                  .toString(), // Added null check
              'subTitle': "Applicants applied this month",
            },
            {
              'title': companyData!
                  .companyData.commonData.applicantsSelected.thisMonth
                  .toString(), // Added null check
              'subTitle': "Applicants have got jobs",
            },
            {
              'title': companyData!
                  .companyData.commonData.mostAppliedJob.applicantsCount
                  .toString(), // Added null check
              'subTitle':
                  "Applicants applied for ${companyData!.companyData.commonData.mostAppliedJob.title ?? 'N/A'}", // Added null check
            },
            {
              'title':
                  "${companyData!.companyData.commonData.mostAppliedJob.growth ?? '0'}%", // Added null check
              'subTitle':
                  "Growth in ${companyData!.companyData.commonData.mostAppliedJob.title ?? 'N/A'} jobs", // Added null check
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
                    physics: const NeverScrollableScrollPhysics(),
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
