import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';

class LoginTextForm extends StatefulWidget {
  final String label;
  final String hintlabel = "";
  final int numb;
  final TextEditingController controller;
  final bool obscure;

  const LoginTextForm({
    super.key,
    required this.label,
    hintlabel,
    this.numb = 1,
    required this.controller,
    this.obscure = false,
  });

  @override
  _LoginTextFormState createState() => _LoginTextFormState();
}

class _LoginTextFormState extends State<LoginTextForm> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: size.height * 0.06,
            child: TextFormField(
              maxLines: widget.numb,
              controller: widget.controller,
              decoration: InputDecoration(
                label: Text(widget.label),
                hintText: widget.hintlabel,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: logintextbox,
                suffixIcon: widget.obscure
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                      )
                    : null,
              ),
              obscureText: _obscureText,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
