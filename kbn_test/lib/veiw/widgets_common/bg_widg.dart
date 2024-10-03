import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';

Widget peoplebgWIdget({img}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Adjust width and padding based on screen width
      double width = constraints.maxWidth;
      bool isMobile = width < 600; // For mobile devices

      return Container(
        color: const Color.fromRGBO(217, 217, 217, 1),
        child: Align(
          alignment: isMobile ? Alignment.center : Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              top: 30.0,
              right: isMobile ? 0 : 30, // No right padding on mobile
              bottom: 30,
              left: isMobile ? 0 : 30, // Align image centrally on mobile
            ),
            child: Image(
              image: AssetImage(img),
              width: isMobile ? width * 0.7 : width * 0.5, // Adjust image width for mobile
              fit: BoxFit.cover, // Ensure the image covers the container well
            ),
          ),
        ),
      );
    },
  );
}


Widget bgWidget({img}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Adjust width and padding based on screen width
      double width = constraints.maxWidth;
      bool isMobile = width < 600; // For mobile devices
      return SizedBox(
        // color: const Color.fromRGBO(217, 217, 217, 1),
        child: Align(
          alignment: isMobile ? Alignment.center : Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(
              top: isMobile ? 10 : 30.0,
              right: isMobile ? 10 : 30.0,
              bottom: isMobile ? 10 : 30.0,
              left: isMobile ? 10 : 0,
            ),
            child: isMobile
                ? Image(width: width, image: const AssetImage(mobileBg))
                : const Image(image: AssetImage(bg)),
          ),
        ),
      );
    },
  );}