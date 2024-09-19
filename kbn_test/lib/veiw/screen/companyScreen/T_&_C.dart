import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/auth/logInPage.dart';
import 'package:kbn_test/veiw/screen/AdminScreen/admin_T_n_C.dart';
import 'package:kbn_test/veiw/screen/companyScreen/cmpny_home.dart';
import 'package:kbn_test/veiw/screen/companyScreen/companyProfile.dart';
import 'package:kbn_test/veiw/widgets_common/home_appbar_box.dart';

class companyT_n_C extends StatelessWidget {
  const companyT_n_C({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            height: size.height,
            width: size.width * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //KBN LOgO
                const Center(child: Image(image: AssetImage(kbnLogo))),
                // APP BAR
                HomeAppBarBox(
                  context,
                  // logOutTo: const CompanyLoginPage(),
                  profilePage: const CompanyProfilePage(),
                  home: const CompanyHomePage(),
                  profileImage:
                      "${ApiServices.baseUrl}/${userDetails['user']['profile_image']}",
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 30, left: 150),
                  child: Text(
                    tachead,
                    style: AppTextStyle.tactexthead,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 150),
                  child: SizedBox(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Text(
                          T_n_C_company,
                          style: AppTextStyle.tactext,
                        ),
                      ],
                    ),
                  )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
