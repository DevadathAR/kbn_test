import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/service/adminMode.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/companymodelClass.dart';
import 'package:kbn_test/service/singletonData.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/lists.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/view/auth/logInPage.dart';

class OverViewCards extends StatefulWidget {
  final VoidCallback onMonthSelect;

  const OverViewCards({
    super.key,
    required this.onMonthSelect,
  });

  @override
  State<OverViewCards> createState() => _OverViewCardsState();
}

class _OverViewCardsState extends State<OverViewCards> {
  CompanyApiResponse? companyData;
  AdminApiResponse? adminData;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _fetchData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onMonthSelect();
    });
  }

  @override
  void didUpdateWidget(covariant OverViewCards oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onMonthSelect != oldWidget.onMonthSelect) {
      _fetchData(); // Refetch data when the month selection changes
    }
  }

  // Future<void> fetchData() async {
  //   final fetchedData = await ApiDataService().fetchDataBasedOnRole();
  //     print("Fetched data: $fetchedData");  // Debugging print

  //   setState(() {
  //     if (isCompany) {
  //      if (fetchedData is CompanyApiResponse) {
  //       companyData = fetchedData;
  //     } else {
  //       // Handle null or incorrect type for company data
  //       print("Error: Fetched data is not of type CompanyApiResponse");
  //       companyData = null;
  //     }
  //     } else {
  //       if (fetchedData is AdminApiResponse) {
  //       adminData = fetchedData;
  //     } else {
  //       // Handle null or incorrect type for admin data
  //       print("Error: Fetched data is not of type AdminApiResponse");
  //       adminData = null;
  //     }
  //     }
  //     isLoading = false;
  //   });
  // }

  void _fetchData() async {
    try {
      // ignore: prefer_typing_uninitialized_variables
      var data;
      if (isCompany) {
        // data = await ApiDataService().fetchCompanyData();
        data = await ApiServices.companyData();

        setState(() {
          companyData = data;
          isLoading = false;
        });
      } else {
        // Fetch admin data if the role is 'Admin'
        // data = await ApiDataService().fetchAdminData();
        data = await ApiServices.adminData();

        setState(() {
          adminData = data;
          isLoading = false;
        });
      }
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
    final companyCommonData = companyData?.companyData?.commonData;
    final adminCommonData = adminData?.adminData?.commonData;

    // if (companyCommonData == null && isCompany) {
    //   return const Center(child: Text("No company data available."));
    // } else if (adminCommonData == null && !isCompany) {
    //   return const Center(child: Text("No admin data available."));
    // }

    final int applicantGrowth =
        (companyCommonData?.applicantsTotal?.thisMonth ?? 0) -
            (companyCommonData?.applicantsTotal?.prevMonth ?? 0);

    final List<Map<String, String>> companyCardData = companyCommonData != null
        ? [
            {
              'title': companyCommonData.companyPosition.toString(),
              'subTitle': "Company position on this month",
            },
            {
              'title': companyCommonData.applicantsTotal!.thisMonth.toString(),
              'subTitle': "Applicants applied this month",
            },
            {
              'title':
                  companyCommonData.applicantsSelected!.thisMonth.toString(),
              'subTitle': "Applicants have got jobs",
            },
            {
              'title': "${companyCommonData.mostAppliedJob?.growth.toString()}0%",
              'subTitle':
                  "Applicants for ${companyCommonData.mostAppliedJob?.title}",
            },
            {
              'title': applicantGrowth.toString(),
              'subTitle': "Total growth on this month",
            },
          ]
        : defaultCardData;

    // Example card data for admins (this is a placeholder, adjust based on actual data structure)
    final List<Map<String, String>> adminCardData = adminCommonData != null
    ? [
        {
          'title': adminCommonData.bestCompany?.companyName?.toString() ?? "N/A", // Null check for companyName
          'subTitle': "Best Company on This Month",
        },
        {
          'title': adminCommonData.companiesAdded?.toString() ?? "0", // Default to "0" if null
          'subTitle': "Companies added this month",
        },
        {
          'title': adminCommonData.kbnCodeAdded?.toString() ?? "0", // Default to "0" if null
          'subTitle': "Companies that received Kbn Code",
        },
        {
          'title': "${(double.tryParse(adminCommonData.mostAppliedCompany?.applicationPercentage ?? '0') ?? 0).toStringAsFixed(0)}%", // Handle null case for applicationPercentage
          'subTitle': "Most Applied Company",
        },
        {
          'title': adminCommonData.totalGrowth?.toString() ?? "0", // Default to "0" if null
          'subTitle': "Total Growth this month",
        },
      ]
    : defaultAdminCardData;


    // Select the appropriate card data based on the user role
    final cardData = isCompany ? companyCardData : adminCardData;

    return isLoading
        ? const Center(child: LinearProgressIndicator())
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
                          title: cardData[index]['title'] ?? "Title",
                          subTitle: cardData[index]['subTitle'] ?? "SubTitle",
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
          Text(title,
              style: isCompany
                  ? AppTextStyle.thirty_w500
                  : AppTextStyle.sixteen_w400_black),
          const Spacer(),
          Text(subTitle,
              textAlign: TextAlign.start, style: AppTextStyle.bodytext_12),
        ],
      ),
    );
  }
}
