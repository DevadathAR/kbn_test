import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/const.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:kbn_test/utilities/widgets/bg_widg.dart';
import 'package:kbn_test/utilities/widgets/login_textformfiled.dart';
import 'package:kbn_test/utilities/widgets/signup_stage_info.dart';
import 'package:kbn_test/veiw/screen/home.dart';

class SignupAcc extends StatefulWidget {
  const SignupAcc({super.key});

  @override
  State<SignupAcc> createState() => _SignupAccState();
}

class _SignupAccState extends State<SignupAcc> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _ischeck = false;
  void _signin() {
    if (_ischeck) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please check the box to proceed.')),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
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
                      "Account details",
                      style: AppTextStyle.subheadertext,
                    ),
                    LoginTextForm(label: "Mail ID", hintlabel: "",controller: emailController),
                    LoginTextForm(label: "Create Password", hintlabel: "",controller: passwordController),
                    LoginTextForm(label: "Confirm Password", hintlabel: "",controller: confirmPasswordController),
                    const Text(
                      tac,
                      style: AppTextStyle.tactext,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: white,
                          checkColor: black,
                          value: _ischeck,
                          onChanged: (bool? value) {
                            setState(() {
                              _ischeck = value ?? false;
                            });
                          },
                        ),
                        const Text(
                          terms,
                          style: AppTextStyle.tactext,
                        )
                      ],
                    ),
                    const SizedBox(height: 150,),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(onTap: _ischeck ? _signin : null,
                        child: Container(
                          height: 33,
                          width: 119,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4),
                              ),
                              color: white,
                              border: Border.all(color: black),
                              gradient:
                                   LinearGradient(colors:_ischeck? loginbutton:InnactiveLoginbutton)),
                          child: const Center(
                              child: Text(
                            "Sign In",
                            style: AppTextStyle.signin,
                          )),
                        ),
                      ),
                    )
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
