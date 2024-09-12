import 'package:flutter/material.dart';

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
  final double width;
  final VoidCallback onTap;

  const BoxButton({
    Key? key,
    required this.title,
    required this.width,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.blue, // Customize the color as needed
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  // Function to create a numeric input field

}
