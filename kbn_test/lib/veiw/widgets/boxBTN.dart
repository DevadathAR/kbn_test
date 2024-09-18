import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';

Widget box({width, height, child, lineWidth = 0.5}) {
  return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black, // Border color
          width: lineWidth, // Border width
        ),
        borderRadius: BorderRadius.circular(2.0), // Optional: Rounded corners
      ),
      child: child);
}

class BoxButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const BoxButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 0.4,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              color: tealblue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  // Function to create a numeric input field
}
