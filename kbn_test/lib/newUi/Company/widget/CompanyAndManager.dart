import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget companyAndManager(BuildContext context, {label, sub, isview}) {
  Size size = MediaQuery.of(context).size;

  return Expanded(
    child: Container(
      height:
          size.height * 0.25, // Increased height to accommodate the TextFormField
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        color: white,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              // Text to show last updated date
              const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0, right: 8),
                  child: Text(
                    "Last updated date",
                    style: AppTextStyle.normalHeading,
                  ),
                ),
              ),
    
              // Image box and other details
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: black),
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        color: Colors.transparent,
                      ),
                      child: const Image(image: AssetImage(personPng)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0), // Adjusted padding
                    child: SizedBox(
                      height: size.height * 0.2,
                      width: size.width * .3,                   /////sized box will overlap in mobile veiew nne dto fix it 
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: label,
                              labelStyle: AppTextStyle.subheadertext,
                              border: InputBorder.none, // Removed border
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: sub,
                              labelStyle: AppTextStyle.normalHeading,
                              border: InputBorder.none, // Removed border
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Email ID",
                              labelStyle: AppTextStyle.normalHeading,
                              border: InputBorder.none, // Removed border
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
         if(isview)addAndSave(context)
         else viewProfile(context)
        ],
      ),
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
              side: BorderSide(color: black),
              shape: RoundedRectangleBorder(
                // Creates rounded corner buttons
                borderRadius: BorderRadius.circular(
                    10), // Change this value for different corner radii
              ),
            ),
            child: const Text(
              "Add",
              style: AppTextStyle.flitertxtblack,
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
              style: AppTextStyle.flitertxt,
            ),
          ),
        ],
      ),
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
        width: 250, // Set the width to 250
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
            style: AppTextStyle.flitertxt,
          ),
        ),
      ),
    ),
  );
}

