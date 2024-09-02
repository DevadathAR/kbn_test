import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/utilities/widgets/bg_widg.dart';
import 'package:kbn_test/utilities/widgets/login_textformfiled.dart';
import 'package:kbn_test/utilities/widgets/next_button.dart';
import 'package:kbn_test/utilities/widgets/signup_stage_info.dart';
import 'package:kbn_test/veiw/auth/signup_education.dart';

class SignupPersonal extends StatelessWidget {
  const SignupPersonal({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          BgWIdget(),
          SizedBox(
            height: size.height * 1,
            width: size.width * 0.5,
            child: Center(
              child: SizedBox(
                height: size.height * 1,
                width: size.width * 0.425,
                child: Column(
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
                                  infocolor: none, bordercolor: black),
                              const Text(" - - - - "),
                              StageInfoCircle(
                                  infocolor: none, bordercolor: black)
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Personal details",
                      style: AppTextStyle.subheadertext,
                    ),
                    LoginTextForm(label: "First name", hintlabel: ""),
                    LoginTextForm(label: "Last name", hintlabel: ""),
                    LoginTextForm(label: "DOB", hintlabel: "DD/MM/YY"),
                    LoginTextForm(label: "Gender", hintlabel: ""),
                    LoginTextForm(
                        label: "Contact", hintlabel: "+91 9988776655"),
                    LoginTextForm(
                        label: "Address", hintlabel: "Address", numb: 4),
                    Align(
                        alignment: Alignment.bottomRight,
                        child:
                            NextButton(context,buttoncolor: logintextbox, text: "Next",nextpage: const SignupEducation()))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
