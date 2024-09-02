import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/widgets/home_appbar_box.dart';
import 'package:kbn_test/utilities/widgets/side_navbar.dart';

class Wishlistpage extends StatelessWidget {
  const Wishlistpage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          SideNavBar(context,),
          Container(
            height: size.height,
            width: size.width - 230,
            color: homecolor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  HomeAppBarBox(context,likeiconcolor: black),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: tealblue,
                    height: 100,
                  ), 
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
