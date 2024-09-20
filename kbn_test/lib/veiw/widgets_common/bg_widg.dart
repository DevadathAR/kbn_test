import 'package:flutter/material.dart';

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


Widget BgWIdget({img}) {
  return Container(
    color: const Color.fromRGBO(217, 217, 217, 1),
    child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, right: 30, bottom: 30),
          child: Image(
            image: AssetImage(img),
          ),
        )),
  );
}
