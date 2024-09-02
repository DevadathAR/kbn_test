import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/profilePage.dart';
import 'package:kbn_test/veiw/screen/wishlistpage.dart';
import 'package:kbn_test/veiw/screen/termsAndCond.dart';

Widget HomeAppBarBox(
  context,{termsiconcolor,likeiconcolor,searchiconcolor}
) {
  Size size = MediaQuery.of(context).size;

  return Container(
    height: 80,
    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2)),color: tealblue),
    width: size.width - 230,
    child: Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            newjob,
            style: AppTextStyle.hoomeSubhead,
          ),
          SizedBox(
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppBarButtons(context,icon: searchPng,iconcolor: searchiconcolor),
                AppBarButtons(context,icon: likePng,nextPage: Wishlistpage(),iconcolor: likeiconcolor),
                AppBarButtons(context,icon: termsPng,nextPage: TermsAndCond(),iconcolor: termsiconcolor),
                AppBarButtons(context,icon: unknownPng, nextPage: ProfilePage()),
              ],
            ),
          )
        ],
      ),
    ),
  );
}



  @override
  Widget AppBarButtons(BuildContext context,{icon,nextPage,iconcolor}) {
    return TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return nextPage;
            },
          ));
        },
        child: Image(image: AssetImage(icon),color: iconcolor,));
  }

