import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';

import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/settingsScreen.dart';

class CompanyProfileScreen extends StatelessWidget {
  const CompanyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ScaffoldBuilder(
        currentPath: "Profile",
        pageName: "Profile",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),

            // PageAndDate(context, pageLabel: "Profile"),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    companyShortView(context),
                    SizedBox(height: 5),
                    companyAndManager(
                      context,
                      label: "Manager name",
                      sub: "Year",
                    ),
                  ],
                ),
                companyDetails(context,
                    label: "Company Details",
                    sub: "${userDetails['user']['address']}",
                    site: "${userDetails['user']['company_website']}",
                    numb: "${userDetails['user']['contact']}"),
              ],
            )

            // Wrap(
            //   spacing: 10, runSpacing: 10,
            //   alignment: WrapAlignment.spaceAround,

            //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     companyShortView(context),
            //     // SizedBox(
            //     //   width: size.width * 0.005,
            //     //   height: size.width > 1200 ? 0 : 5,
            //     // ),
            //     companyAndManager(
            //       context,
            //       label: "Manager name",
            //       sub: "Year",
            //     ),
            //   ],
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 10.0),
            //   child: size.width > 900
            //       ? Wrap(
            //           spacing: 10, runSpacing: 10,
            //           alignment: WrapAlignment.spaceAround,
            //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             companyDetails(
            //               context,
            //               label: "Company Details",
            //               sub: "Address",
            //             ),
            //             // SizedBox(
            //             //   width: size.width * 0.005,
            //             // ),
            //             // otherDetails(
            //             //   context,
            //             //   label: "Team Members",
            //             // ),
            //             // // SizedBox(
            //             // //   width: size.width * 0.005,
            //             // // ),
            //             // otherDetails(
            //             //   context,
            //             //   label: "Job Positions",
            //             // ),
            //             // // SizedBox(
            //             // //   width: size.width * 0.005,
            //             // // ),
            //             // otherDetails(
            //             //   context,
            //             //   label: "Commmunity",
            //             // )
            //           ],
            //         )
            //       : Column(
            //           // spacing: 10, runSpacing: 10,
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             companyDetails(
            //               context,
            //               label: "Compnay Details",
            //               sub: "Address",
            //             ),
            //             // SizedBox(
            //             //   width: size.width * 0.005,
            //             // ),
            //             // otherDetails(
            //             //   context,
            //             //   label: "Team Members",
            //             // ),
            //             // // SizedBox(
            //             // //   width: size.width * 0.005,
            //             // // ),
            //             // otherDetails(
            //             //   context,
            //             //   label: "Job Positions",
            //             // ),
            //             // // SizedBox(
            //             // //   width: size.width * 0.005,
            //             // // ),
            //             // otherDetails(
            //             //   context,
            //             //   label: "Commmunity",
            //             // )
            //           ],
            //         ),
            // )
          ],
        ));
  }
}

Widget companyAndManager(
  BuildContext context, {
  label,
  sub,
}) {
  Size size = MediaQuery.of(context).size;

  return Container(
    width: size.width > 900 ? (size.width - 200) * .6 : null,
    height: 250,
    // height:
    //     size.height * 0.35, // Increased height to accommodate the TextFormField
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      color: white,
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        // Text to show last updated date
        const Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: 8.0, right: 8),
            child: Text(
              "Last updated date",
              style: AppTextStyle.normalText,
            ),
          ),
        ),

        // Image box and other details
        Row(
          children: [
            Container(
              // height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(color: black),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                color: Colors.transparent,
              ),
              child: const Image(image: AssetImage(personPng)),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: label,
                      labelStyle: AppTextStyle.fourteenW400,
                      border: InputBorder.none, // Removed border
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: sub,
                      labelStyle: AppTextStyle.normalText,
                      border: InputBorder.none, // Removed border
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Email ID",
                      labelStyle: AppTextStyle.normalText,
                      border: InputBorder.none, // Removed border
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: addAndSave(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget addAndSave(context) {
  Size size = MediaQuery.of(context).size;

  return Align(
    alignment: Alignment.bottomRight,
    child: Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 10),
      child: Wrap(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: black),
              shape: RoundedRectangleBorder(
                // Creates rounded corner buttons
                borderRadius: BorderRadius.circular(
                    10), // Change this value for different corner radii
              ),
            ),
            child: const Text(
              "Add",
              style: AppTextStyle.bodytext_12,
            ),
          ),
          SizedBox(width: size.width * 0.005),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: tealblue,
              shape: RoundedRectangleBorder(
                // Creates rounded corner buttons
                borderRadius: BorderRadius.circular(
                    10), // Change this value for different corner radii
              ),
            ),
            child: const Text(
              "Save",
              style: AppTextStyle.bodytextwhite,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget companyDetails(context, {label, sub, isview, numb, site}) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      width: size.width > 900 ? (size.width - 225) * 0.4 : null,
      // height: size.height * 0.5,
      height: 455,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)), color: white),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    label,
                    style: AppTextStyle.twenty_w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    sub,
                    style: AppTextStyle.fourteenW400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    numb,
                    style: AppTextStyle.fourteenW400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    site,
                    style: AppTextStyle.fourteenW400,
                  ),
                )
                // TextFormField(
                //   maxLines: 6,
                //   decoration: InputDecoration(
                //     hintText: sub,
                //     border: InputBorder.none,
                //   ),
                //   textAlign: TextAlign.left, // Center the text and hint
                // ),
                // TextFormField(
                //   decoration:  InputDecoration(
                //     hintText: numb,
                //     border: InputBorder.none,
                //   ),
                // ),
                // TextFormField(
                //   decoration:  InputDecoration(
                //     hintText: site,
                //     border: InputBorder.none,
                //   ),
                // ),
              ],
            ),
          ),
          addAndSave(context)
        ],
      ),
    ),
  );
}

// Widget otherDetails(context, {label, sub, isview}) {
//   Size size = MediaQuery.of(context).size;
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 5.0),
//     child: Container(
//       width: size.width > 900 ? (size.width - 225) * 0.24 : null,
//       height: size.height * 0.5,
//       decoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(6)), color: white),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 15.0, left: 10),
//             child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Text(
//                     label,
//                     style: AppTextStyle.twenty_w500,
//                   ),
//                 ),
//                 TextFormField(
//                   maxLines: 6,
//                   decoration: InputDecoration(
//                     hintText: sub,
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           addAndSave(context)
//         ],
//       ),
//     ),
//   );
// }

Widget companyShortView(BuildContext context, {label, sub, email}) {
  Size size = MediaQuery.of(context).size;

  return Container(
    width: size.width > 900 ? (size.width - 200) * .6 : null,
    height: 200,

    // height: 200,
    // height:
    //     size.height * 0.35, // Increased height to accommodate the TextFormField
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      color: white,
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text to show last updated date
        const Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: 8.0, right: 8),
            child: Text(
              "Last updated date",
              style: AppTextStyle.normalText,
            ),
          ),
        ),

        // Image box and other details
        Row(
          children: [
            Container(
              // height: 100,
              width: 100,
              // decoration: BoxDecoration(
              // border: Border.all(color: black),
              // borderRadius: const BorderRadius.all(Radius.circular(6)),
              //   color: Colors.transparent,
              // ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "${ApiServices.baseUrl}/${userDetails['user']['profile_image']}",
                ),
                radius: 50,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        "${userDetails['user']['name']}",
                        style: AppTextStyle.fourteenW400,
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text("${userDetails['user']['kbn_code']}",
                            style: AppTextStyle.normalText),
                      )),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text("${userDetails['user']['email']}",
                          style: AppTextStyle.normalText),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: viewProfile(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget viewProfile(BuildContext context) {
  // Size size = MediaQuery.of(context).size;

  return Align(
    alignment: Alignment.bottomRight,
    child: Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 10),
      child: SizedBox(
        width: 150, // Set the width to 250
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: tealblue,
            shape: RoundedRectangleBorder(
              // Creates rounded corner buttons
              borderRadius: BorderRadius.circular(10), // Adjust corner radius
            ),
          ),
          child: const Text(
            "View Profile",
            style: AppTextStyle.bodytextwhite,
          ),
        ),
      ),
    ),
  );
}
