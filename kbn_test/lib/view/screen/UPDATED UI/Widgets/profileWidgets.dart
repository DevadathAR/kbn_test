import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/view/auth/logInPage.dart';
import 'package:kbn_test/view/screen/UPDATED%20UI/Screens/Scaffold/scaffoldBuilder.dart';

Widget profile_details(BuildContext context, {label, sub, email}) {
  Size size = MediaQuery.of(context).size;

  return Container(
    width: size.width > 900 ? (size.width - 200) * .6 : null,
    height: 200,
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
            SizedBox(
              width: 100,
              child: CircleAvatar(
                backgroundImage: isCompany
                    ? NetworkImage(
                        "${ApiServices.baseUrl}/${userDetails['user']['profile_image']}")
                    : const AssetImage(
                        kbnLogo,
                      ) as ImageProvider,
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
                  if (isCompany)
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text("${userDetails['user']['kbn_code']}"!="null"?"${userDetails['user']['kbn_code']}":"Not Assigned",
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
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}