import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/utilities/widgets/home_appbar_box.dart';
import 'package:kbn_test/utilities/widgets/home_filter_box.dart';
import 'package:kbn_test/utilities/widgets/latestjob_card.dart';
import 'package:kbn_test/utilities/widgets/side_navbar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          SideNavBar(context, viewhome: black),
          SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width - 230,
              color: lowwhite,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeAppBarBox(context),
                    const SizedBox(
                      height: 10,
                    ),
                    HomeFilterBox(context),
                    const SizedBox(
                      height: 10,
                    ),const Text(latestjob,style: AppTextStyle.tactexthead,)
                    ,const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 3/2
                                  ),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return LatestJobCard(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
