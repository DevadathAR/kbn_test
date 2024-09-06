import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/company_auth/cmpny_login.dart';
import 'package:kbn_test/veiw/screen/companyScreen/T_&_C.dart';
import 'package:kbn_test/veiw/widgets/boxBTN.dart';
import 'package:kbn_test/veiw/widgets/home_appbar_box.dart';

class CompanyProfilePage extends StatelessWidget {
  final Uint8List? uploadedImage;
  const CompanyProfilePage({super.key, this.uploadedImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // AppBAr Section.................................
          Image.asset(
            kbnLogo, // Kbn LoGO
            height: 40,
          ),
          // appbarWidget
          HomeAppBarBox(context,
              T_and_C: const companyT_n_C(),
              logOutTo: const CompanyLoginPage()),
          //Body Section......................................
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Left Section - Company Information
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0),
                        image: const DecorationImage(
                          image: AssetImage(
                              'assets/logo.png'), // Replace with your image path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('LUMA SOLUTIONS',
                        style: AppTextStyle.normalHeading),
                    const SizedBox(height: 5),
                    const Text('KBN Code', style: AppTextStyle.bodytext),
                    const SizedBox(height: 20),

                    // Address ANd Email Section
                    Container(
                      width: 190,
                      height: 326,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 0.3, // Border width
                        ),
                        borderRadius: BorderRadius.circular(
                            4.0), // Optional: Rounded corners
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Address',
                                  style: AppTextStyle.normalText,
                                ),
                                Icon(Icons.edit),
                              ],
                            ),
                            SizedBox(
                                height:
                                    8), // Add some space before the TextField
                            TextField(
                              decoration: InputDecoration(
                                border: InputBorder
                                    .none, // Remove the outline of the TextField
                              ),
                            ),
                            Spacer(), // Add a spacer to push the rest of the content to the bottom
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Mail ID',
                                  style: AppTextStyle.normalText,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Contact no',
                                  style: AppTextStyle.normalText,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Link',
                                  style: AppTextStyle.normalText,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'LTD',
                                  style: AppTextStyle.normalText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 16),
                // Middle Section - Recruitment Details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Recruitment details',
                        style: AppTextStyle.normalHeading),
                    const SizedBox(height: 10),
                    Container(
                      width: 457,
                      height: 498,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text(
                          'web development\n\n'
                          'web development job posting has open in 12-4-2024\n\n'
                          'web development job posting has closed in 22-4-2024',
                          style: AppTextStyle.normalText),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                // Right Section - Add New Recruitment
                Container(
                  width: 315,
                  height: 498,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Row(
                          children: [
                            Spacer(),
                            Text('Add a new Recruitment',
                                style: AppTextStyle.normalHeading),
                            SizedBox(height: 10),
                            Spacer(),
                            Icon(Icons.edit)
                          ],
                        ),
                        const SizedBox(height: 10),
                        _textFeild(width: 278, hight: 93, label: 'Job Summary'),
                        const SizedBox(height: 10),
                        _textFeild(width: 278, hight: 26, label: 'Position'),
                        const SizedBox(height: 4),
                        _textFeild(width: 278, hight: 26, label: 'Company'),
                        const SizedBox(height: 5),
                        _textFeild(width: 278, hight: 26, label: 'Location'),
                        const SizedBox(height: 5),
                        _textFeild(
                            width: 278, hight: 26, label: 'Employment Type'),
                        const SizedBox(height: 5),
                        _textFeild(width: 278, hight: 26, label: 'Vacancy'),
                        const SizedBox(height: 10),
                        _textFeild(
                            hight: 57,
                            width: 278,
                            label: 'Key Responsibilities'),
                        const SizedBox(height: 10),
                        _textFeild(
                            hight: 100, width: 278, label: 'Requirements'),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 278,
                          child: Row(
                            children: [
                              const Spacer(),
                              box(
                                width: 76,
                                height: 20,
                                child: GestureDetector(
                                  onTap: () => (), // Adding onTap function
                                  child: const Center(
                                    child: Text(
                                      'CREATE',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: tealblue,
                                        fontSize: 10,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFeild({width, hight, label}) {
    return SizedBox(
        width: width,
        height: hight,
        child: TextField(
          decoration: InputDecoration(
            labelText: label, // The text to display as the label
            labelStyle: AppTextStyle.normalText, // The style for the label text
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black, // Border color
                width: 2.0, // Border width
              ),
            ),
          ),
          maxLines:
              null, // Allows the TextField to take up the full height of the container
          expands: true, // Makes the TextField fill the Container's height
        ));
  }

  Widget _buildRecruitmentField(String label) {
    return SizedBox(
      height: 25,
      width: 278,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: TextField(
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black, // Border color
                width: 2.0, // Border width
              ),
            ),
          ),
        ),
      ),
    );
  }
}
