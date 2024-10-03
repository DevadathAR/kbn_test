import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';

class LoginTextForm extends StatefulWidget {
  final String label;
  final String hintlabel; // Update this to be non-final so it works properly
  final int numb;
  final TextEditingController controller;
  final bool obscure;
  final double hight;

  const LoginTextForm({
    super.key,
    required this.label,
    this.hintlabel = "", // Default value for hint label
    this.numb = 1,
    required this.controller,
    this.obscure = true,
    this.hight = 20, // Password fields are obscured by default
  });

  @override
  _LoginTextFormState createState() => _LoginTextFormState();
}

class _LoginTextFormState extends State<LoginTextForm> {
  // Initially, the password field should be obscured
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Color of the shadow
                spreadRadius: 5, // How much the shadow should spread
                blurRadius: 5, // How soft the shadow should be
                offset: const Offset(0, 3), // Horizontal and vertical offset
              ),
            ],
          ),
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
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    )
                  : null,
            ),
            obscureText: widget.obscure
                ? _obscureText
                : false, // Obscure text based on state
          ),
        ),
        SizedBox(height: widget.hight),
      ],
    );
  }
}