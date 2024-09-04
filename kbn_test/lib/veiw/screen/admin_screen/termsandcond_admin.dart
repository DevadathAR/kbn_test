import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/user_screen/home.dart';
import 'package:kbn_test/veiw/widgets/back_button.dart';
import 'package:kbn_test/veiw/widgets/home_appbar_box.dart';

class TaCAdmin extends StatelessWidget {
  const TaCAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [GoBack(context,backpage:Home()),
          SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Image(image: AssetImage(logoPng))),
                  HomeAppBarBox(context),
                  
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 100,bottom: 30,left: 150),
                    child: Text(
                      tachead,
                      style: AppTextStyle.tactexthead,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 150),
                    child: SizedBox(
                        child: Text(
                      termsandcondAdmin,
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
