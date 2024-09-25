import 'package:flutter/material.dart';
import 'package:kbn_test/newUi/Company/widget/PaymentForm.dart';
import 'package:kbn_test/newUi/Company/widget/TransationList.dart';

class CompanyTransation extends StatelessWidget {
  const CompanyTransation({super.key});

  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.6,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Wrap(spacing: 10, runSpacing: 10, children: [
            transationPageList(context),
            paymentFormField(context)


          ]),
        ),
      ),
    );
  }
}