import 'package:flutter/material.dart';

const logintextbox =Color.fromRGBO(253, 253, 253, 1) ;
const sidebarWhite = Color.fromRGBO(251, 251, 251, 1);
const homecolor = Color.fromRGBO(217, 217, 217, 1);
const lowwhite = Color.fromRGBO(248, 248, 248, 1);
const black =Colors.black;
const semitransp =Color.fromARGB(222, 18, 18, 18);
const shadowblack =Color.fromARGB(138, 18, 18, 18);
const white = Colors.white;
const yellow = Color.fromARGB(255, 183, 216, 61);
const bluee = Color.fromARGB(255, 32, 236, 236);
const green = Color.fromRGBO(88, 186, 78, 1);
const none = Color.fromARGB(0, 0, 0, 0);
const tealblue =Color.fromRGBO(19, 131, 149, 1) ;
const loginbutton = [Color.fromRGBO(88, 186, 78, 1),Color.fromRGBO(19, 131, 149, 1)];
const InnactiveLoginbutton = [Color.fromRGBO(89, 186, 78, 0.242),Color.fromRGBO(19, 131, 149, 0.242)];
Color getStatusColor(String status) {
  switch (status) {
    case "Selected":
      return const Color.fromARGB(255, 118, 198, 109);
    case "Apply for this Job":
      return Colors.teal;
    case "Rejected":
      return Colors.red;
    case "Submitted":
      return Colors.teal;
    default:
      return const Color.fromARGB(198, 0, 0, 0); // Default color if none of the cases match
  }
}

Color getTxtColor(String status) {
  switch (status) {
    case "Selected":
      return black;
    case "Apply for this Job":
      return white;
    case "Rejected":
      return black;
    case "Submitted":
      return black;
    default:
      return white;
  }
}