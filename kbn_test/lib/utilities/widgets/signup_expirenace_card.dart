import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/utilities/widgets/signup_education_card.dart';

Widget ExperienceCard(context,) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Container(
      width: size.width * 0.425,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
          color: white,
          border: Border.all(color: black)),
      child: Column(
        children: [
          const Text(
            "Experiance",
            style: AppTextStyle.subheadertext,
          ),
          EducationTextForm(context,data: "Company name"),
          EducationTextForm(context,data: "Year"),
          EducationTextForm(context,data: "Position"),
          EducationTextForm(context,data: "State"),
          EducationTextForm(context,data: "About you",lines: 3),
          
        ],
      ),
    ),
  );
}

