import 'package:flutter/material.dart';

Widget GoBack(BuildContext context, {required homePage}) {
  Size size = MediaQuery.of(context).size;

  return Positioned(
    top: size.height * 0.4, // Adjust position as needed
    left: 20, // Adjust position as needed
    child: GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => homePage,)); // Navigate back to the previous page
      },
      child: const Icon(
        Icons.arrow_back_ios_sharp,
        size: 30, // Adjust icon size as needed
        color: Colors.black, // Adjust icon color as needed
      ),
    ),
  );
}
