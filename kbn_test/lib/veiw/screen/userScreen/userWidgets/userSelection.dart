import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';

class SignUpUserSelectionWidget extends StatefulWidget {
  final String appuser;
  final bool isSelected;
  final VoidCallback onTap;

  const SignUpUserSelectionWidget({
    super.key,
    required this.appuser,
    required this.isSelected,
    required this.onTap,
  });

  @override
  _SignUpUserSelectionState createState() => _SignUpUserSelectionState();
}

class _SignUpUserSelectionState extends State<SignUpUserSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SignUpUserSelection(
        appuser: widget.appuser,
        colors: widget.isSelected ? tealblue : none,
        txtcolor: widget.isSelected
            ? AppTextStyle.bodytextwhite
            : AppTextStyle.bodytext,
      ),
    );
  }
}

class SignUpUserSelection extends StatelessWidget {
  final String appuser;
  final Color colors;
  final TextStyle txtcolor;

  const SignUpUserSelection({
    super.key,
    required this.appuser,
    this.colors = none,
    this.txtcolor = AppTextStyle.bodytext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: colors),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              appuser,
              style: txtcolor,
            ),
          ),
        ),
      ),
    );
  }
}
