import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/utilities/widgets/bg_widg.dart';
import 'package:kbn_test/utilities/widgets/next_button.dart';
import 'package:kbn_test/utilities/widgets/signup_education_card.dart';
import 'package:kbn_test/utilities/widgets/signup_stage_info.dart';
import 'package:kbn_test/veiw/auth/signup_skill.dart';

class SignupEducation extends StatefulWidget {
  const SignupEducation({super.key});

  @override
  _SignupEducationState createState() => _SignupEducationState();
}

class _SignupEducationState extends State<SignupEducation> {
  List<Widget> educationCards = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    educationCards.add(EducationCard(context, educt: "SSLC"));
    educationCards.add(EducationCard(context, educt: "Higher Secondary"));
  }

  void _addEducationCard() {
    setState(() {
      educationCards.add(EducationCard(context, educt: "New Education"));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          BgWIdget(),
          SizedBox(
            height: size.height,
            width: size.width * 0.5,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "SIGN UP",
                          style: AppTextStyle.headertext,
                        ),
                        Row(
                          children: [
                            StageInfoCircle(
                                infocolor: tealblue, bordercolor: none),
                            const Text(" - - - - "),
                            StageInfoCircle(
                                infocolor: tealblue, bordercolor: none),
                            const Text(" - - - - "),
                            StageInfoCircle(
                                infocolor: none, bordercolor: black),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Educational details",
                      style: AppTextStyle.subheadertext,
                    ),
                    const SizedBox(height: 20),
                    ...educationCards,
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NextButton(
                          context,
                          buttoncolor: logintextbox,
                          text: "Add",
                          onPressed: _addEducationCard,
                        ),
                        NextButton(
                          context,
                          buttoncolor: logintextbox,
                          text: "Next",
                          nextpage: const SignupSkill(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
