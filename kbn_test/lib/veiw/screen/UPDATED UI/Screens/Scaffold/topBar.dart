import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/jobScreen.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    

    return size.width < 900
        ? Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage(kbnLogo),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(firmName,
                  style: size.height > 400
                      ? AppTextStyle.twntyFive_W600
                      : AppTextStyle.fifteenW600),
            ],
          )
        : 
        Wrap(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(firmName,
                        style: size.height > 400
                            ? AppTextStyle.twntyFive_W600
                            : AppTextStyle.fifteenW600),
                    // Search bar and button
                  // if(view) 
                  //  Row(
                  //     children: [
                  //       SizedBox(
                  //         width: size.width * .13,
                  //         child: const TextField(
                  //           decoration: InputDecoration(
                  //             border: OutlineInputBorder(),
                  //             hintText: 'Search...',
                  //           ),
                  //         ),
                  //       ),
                  //       const SizedBox(width: 10),
                  //       GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => CompanyJobpage()),
                  //           );
                  //         },
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           width: size.width * .17,
                  //           height: 38,
                  //           decoration: ShapeDecoration(
                  //             color: const Color(0xFF138395),
                  //             shape: RoundedRectangleBorder(
                  //               side: const BorderSide(width: 0.40),
                  //               borderRadius: BorderRadius.circular(6),
                  //             ),
                  //           ),
                  //           child: const Text(
                  //             "+ Add new recruitment",
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //         ),
                  //       ),

                  //       // ),
                  //       const SizedBox(width: 10),
                  //     ],
                  //   ),
                  ],
                ),
              ),
            ],
          );
  }
}
