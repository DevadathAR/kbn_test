import 'package:flutter/material.dart';
import 'package:kbn_test/newUi/Company/widget/HorizontalCardList.dart';
import 'package:kbn_test/newUi/Company/widget/MessagePageCompose.dart';
import 'package:kbn_test/newUi/Company/widget/MessagePageList.dart';
import 'package:kbn_test/newUi/Company/widget/PageAndDate.dart';

class CompanyMessage extends StatelessWidget {
  const CompanyMessage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.6,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Wrap(spacing: 10, runSpacing: 10, children: [
            messagePageList(context),
            messagePageCompose(context),
          ]),
        ),
      ),
    );
  }
}
