import 'package:flutter/material.dart';
import 'package:kbn_test/newUi/Company/widget/CompanyAndManager.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget companyDetails(context, {label, sub,isview}) {
  Size size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 0.235,
    height: size.height * 0.5,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)), color: white),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  label,
                  style: AppTextStyle.subheadertext,
                ),
              ),
              TextFormField(
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: sub,
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.left, // Center the text and hint
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Contact num",
                  border: InputBorder.none,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Website",
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
       addAndSave(context)
       
      ],
    ),
  );
}

Widget otherDetails(context, {label, sub,isview}) {
  Size size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 0.24,
    height: size.height * 0.5,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)), color: white),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  label,
                  style: AppTextStyle.subheadertext,
                ),
              ),
              TextFormField(
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: sub,
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
       addAndSave(context)
      ],
    ),
  );
}
