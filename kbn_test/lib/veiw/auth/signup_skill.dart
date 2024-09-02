import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/utilities/widgets/bg_widg.dart';
import 'package:kbn_test/utilities/widgets/login_textformfiled.dart';
import 'package:kbn_test/utilities/widgets/next_button.dart';
import 'package:kbn_test/utilities/widgets/signup_expirenace_card.dart';
import 'package:kbn_test/utilities/widgets/signup_stage_info.dart';
import 'package:kbn_test/veiw/auth/signup_acc.dart';

class SignupSkill extends StatefulWidget {
  const SignupSkill({super.key});

  @override
  _SignupSkillState createState() => _SignupSkillState();
}

class _SignupSkillState extends State<SignupSkill> {
  List<Widget> expCards = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    expCards.add(ExperienceCard(context));
  }

  void _addExpCard() {
    setState(() {
      expCards.add(ExperienceCard(context));
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
    width: size.width * 0.425,
            child: SingleChildScrollView(
              child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "SIGN UP",
                          style: AppTextStyle.headertext,
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              StageInfoCircle(
                                  infocolor: tealblue, bordercolor: none),
                              const Text(" - - - - "),
                              StageInfoCircle(
                                  infocolor: tealblue, bordercolor: none),
                              const Text(" - - - - "),
                              StageInfoCircle(
                                  infocolor: tealblue, bordercolor: none),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Skills & Experience",
                      style: AppTextStyle.subheadertext,
                    ),
                    LoginTextForm(
                      numb: 2,
                      label: "Skills",
                      hintlabel: "Skills",
                    ),
                    ...expCards,
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: NextButton(
                        context,
                        buttoncolor: logintextbox,
                        text: "Add",
                        onPressed: _addExpCard,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: NextButton(
                        context,
                        buttoncolor: logintextbox,
                        text: "Next",
                        nextpage: const SignupAcc(), 
                      ),
                    ),
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
