import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/AdminScreen/adminLogin.dart';
import 'package:kbn_test/veiw/widgets/home_appbar_box.dart';

class AdminTnC extends StatelessWidget {
  const AdminTnC({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: size.height,
              width: size.width * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //KBN LOgO
                  const Center(child: Image(image: AssetImage(kbnLogo))),
                  // APP BAR
                  HomeAppBarBox(context,
                      T_and_C: const AdminTnC(), logOutTo: const AdminLogIn()),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 100, bottom: 30, left: 150),
                    child: Text(
                      tachead,
                      style: AppTextStyle.tactexthead,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 150),
                    child: SizedBox(
                        child: Text(
                      T_n_C_admin,
                      style: AppTextStyle.tactext,
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
