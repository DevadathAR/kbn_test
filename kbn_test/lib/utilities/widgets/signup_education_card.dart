import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

Widget EducationCard(context,{educt}) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Container(
      height: 240,
      width: size.width * 0.425,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
          color: white,
          border: Border.all(color: black)),
      child: Column(
        children: [
          Text(
            educt,
            style: AppTextStyle.subheadertext,
          ),
          EducationTextForm(context,data: "Institute"),
          EducationTextForm(context,data: "Year"),
          EducationTextForm(context,data: "Percentage"),
          EducationTextForm(context,data: "State"),
          
        ],
      ),
    ),
  );
}


  Widget EducationTextForm(BuildContext context,{data,lines=1}) {
    return TextFormField(maxLines: lines,
      decoration:  InputDecoration(
          label: Text(data),
          hintText: data,
          border: const OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: logintextbox),
    );
  }
