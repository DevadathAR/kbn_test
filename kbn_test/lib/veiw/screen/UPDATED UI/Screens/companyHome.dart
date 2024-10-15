import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/service/companyModelClass.dart';
import 'package:kbn_test/service/singletonData.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/messageScreen.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/statisticScreen.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/chartWidget.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/messageDispaly.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/messageWidget.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/payResult.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/simpleTable.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/verticalTable.dart';

class CompanyHome extends StatefulWidget {
  const CompanyHome({super.key});

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  Apiresponse? companyData; // To hold the API response
  bool isLoading = true; // To manage the loading state

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  // Function to fetch data from the singleton service
  void _fetchData() async {
    try {
      Apiresponse response = await ApiDataService().fetchCompanyData();
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
    Size size = MediaQuery.of(context).size;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (companyData == null) {
      return const Center(child: Text("No data available"));
    }

    return ScaffoldBuilder(
      pageName: "Overview",
      currentPath: "Overview",
      child: SizedBox(
        // height: 410,
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            // First column (Charts and Horizontal Table)
            SizedBox(
              width: size.width > 1200 ?( size.width-200)*0.49 : null,
              child: Column(
                children: [
                  GestureDetector(
                    child: ChartWidget(
                      companyData: companyData!.companyData,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CompanyStatisticScreen()));
                    },
                  ), // Pass data here
                  const SizedBox(height: 10),
                  HorizontalTable(
                      jobsData: companyData!
                          .companyData.jobsPageData), // Pass data here
                ],
              ),
            ),

            // Second column (Vertical Table)
            SizedBox(
              width: size.width > 1200
                  ? (size.width - 200) * 0.49
                  : null, // Adjust the width as necessary
              child: VerticalTable(
                  applicantsData: companyData!
                      .companyData.applicantsPageData), // Pass data here
            ),

            // Third column (Message and Pay Result)
            // SizedBox(
            //   width: size.width > 1200
            //       ? (size.width - 200) * 0.2
            //       : null, // Adjust the width as necessary
            //   child: Column(
            //     children: [
            //       MessagePageList(
            //         height: 270,
            //         imgSize: 20,
            //         paddingSeparation: 5,
            //         /*tileCount: 3,*/ 
            //         tileHeight: 65,
            //         viewReplyButton: false,
            //         messagesPageData: companyData!.companyData.messagesPageData,
            //       ),
            //       // MessageWidget(
            //       //     messages: companyData!
            //       //         .companyData.messagesPageData), // Pass data here
            //       const SizedBox(height: 10),
            //       isCompany ? const PayRemainder() : const PayResult(),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
