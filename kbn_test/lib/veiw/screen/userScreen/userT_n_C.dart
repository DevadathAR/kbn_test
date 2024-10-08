import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/userScreen/home.dart';
import 'package:kbn_test/veiw/widgets_common/home_appbar_box.dart';

class user_T_n_C extends StatelessWidget {
  const user_T_n_C({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              width: size.width * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Image(image: AssetImage(kbnLogo))),
                  HomeAppBarBox(
                    context,
                    home: const UserHome(),
                    profileImage:
                        "${ApiServices.baseUrl}/${userDetails['user']['profile_image']}",

                    // logOutTo: const UserHome(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 100, bottom: 30, left: 150),
                    child: Text(
                      tachead,
                      style: AppTextStyle.twentyFour_W400,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 150),
                    child: SizedBox(
                        child: Text(
                      T_n_C_user,
                      style: AppTextStyle.fourteenW400,
                    )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
