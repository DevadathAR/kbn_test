import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';

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
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(kbnLogo),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
               Text(firmName, style:size.height>400? AppTextStyle.firmHead:AppTextStyle.firmHeadSmall),
            ],
          )
        : Wrap(children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(firmName, style:size.height>400? AppTextStyle.firmHead:AppTextStyle.firmHeadSmall),
                  // Search bar and button
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * .13,
                        child: const TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Search...',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        alignment: Alignment.center,
                        width: size.width * .17,
                        height: 38,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF138395),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 0.40),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          "+ Add new recruitment",
                          style: TextStyle(color: white),
                        ),
                      ),
                      // ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
          ]);
  }
}
