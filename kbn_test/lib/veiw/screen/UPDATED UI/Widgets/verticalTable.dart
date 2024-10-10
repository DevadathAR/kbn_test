import 'package:flutter/material.dart';
import 'package:kbn_test/service/adminMode.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/applicantsScreen.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/commonTable.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/showAll_bTn.dart';
import 'package:kbn_test/veiw/widgets_common/boxBTN.dart';

import '../../../../service/companymodelClass.dart'; // Make sure your model class path is correct

class VerticalTable extends StatelessWidget {
  final ApplicantsPageData? applicantsData;
  final List<ToBeApprovedCompany>? toApproveData;

  const VerticalTable({
    super.key,
    this.applicantsData,
    this.toApproveData,
  });

  @override
  Widget build(BuildContext context) {
    // Define the headers based on whether the user is a company or applicant
    final List<String> headers = isCompany
        ? [
            'Applicant Name',
            'Designation',
            '',
          ]
        : [
            'Company Name',
            'Website Link',
            '' // Third column for the button
          ];

     // Define table data based on user type
    final List<List<dynamic>> rowData = isCompany
        ? applicantsData?.selected.map((applicant) {
            return [applicant.name, applicant.designation];
          }).toList() ?? []
        : toApproveData?.map((company) {
            return [company.companyName, company.website];
          }).toList() ?? [];


    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder(
                horizontalInside: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 0.5,
                ),
                verticalInside: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 0.5,
                ),
              ),
              columnWidths: const {
                0: FlexColumnWidth(), // Responsive width for name column
                1: FlexColumnWidth(), // Responsive width for designation/website column
                2: FixedColumnWidth(120), // Fixed width for the button column
              },
              children: [
                // Add the header row
                TableRow(
                  children: [
                    _buildHeaderCell(headers[0]), // 'Applicant/Company Name'
                    _buildHeaderCell(headers[1]), // 'Designation/Website Link'
                    _buildHeaderCell(''), // Empty header for the third column
                  ],
                ),
                // Add the data rows dynamically
                for (var row in rowData.take(6))
                  TableRow(
                    children: [
                      _buildDataCell(row[0].toString()), // Name/Company Name
                      _buildDataCell(row[1].toString()), // Designation/Website Link
                      _buildButtonCell(context), // Button for 'View Details'
                    ],
                  ),
              ],
            ),
            const SizedBox(
                height: 15), // Spacing between table and "Show All" button
            ShowAllBtn(onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const CompanyApplicantScreen();
                },
              ));
            }),
          ],
        ),
      ),
    );
  }

  // Widget for header cell
  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 23.5, horizontal: 5.0), // Increase vertical padding
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Widget for data cell
  Widget _buildDataCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 23.5, horizontal: 5.0), // Increase vertical padding
      child: Text(
        text,
        style: AppTextStyle.normalText,
        textAlign: TextAlign.center,
      ),
    );
  }

  // Widget for the button cell
  Widget _buildButtonCell(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BoxButton(
        title: "View Details",
        onTap: () {
          showProfileDialog(context);
        },
      ),
    );
  }
}
