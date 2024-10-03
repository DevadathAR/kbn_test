import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

class ShowAllBtn extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ShowAllBtn({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: tealblue,
          borderRadius: BorderRadius.circular(4),
        ),
        child:  Text(title, style: AppTextStyle.bodytextwhite),
      ),
    );
  }
}
