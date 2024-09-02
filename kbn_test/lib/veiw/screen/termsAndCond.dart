import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/utilities/widgets/home_appbar_box.dart';
import 'package:kbn_test/utilities/widgets/side_navbar.dart';

class TermsAndCond extends StatelessWidget {
  const TermsAndCond({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          SideNavBar(
            context,
          ),
          Container(
            height: size.height,
            width: size.width - 230,
            color: homecolor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeAppBarBox(context, termsiconcolor: black),
                  
                  const Padding(
                    padding: EdgeInsets.only(top: 100,bottom: 30),
                    child: Text(
                      tachead,
                      style: AppTextStyle.tactexthead,
                    ),
                  ),
                  const SizedBox(
                      child: Text(
                    termsandcond,
                    style: AppTextStyle.tactext,
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
