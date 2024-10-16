import 'package:flutter/material.dart';

const logintextbox = Color.fromRGBO(253, 253, 253, 1);
const sidebarWhite = Color.fromRGBO(251, 251, 251, 1);
const homecolor = Color.fromRGBO(217, 217, 217, 1);
const lowwhite = Color.fromRGBO(248, 248, 248, 1);
const black = Colors.black;
const white = Colors.white;
const yellow = Color.fromARGB(255, 183, 216, 61);
const green = Color.fromRGBO(88, 186, 78, 1);
const none = Color.fromARGB(0, 0, 0, 0);
const tealblue = Color.fromRGBO(19, 131, 149, 1);
const semitransp = Color.fromARGB(222, 18, 18, 18);
const shadowblack = Color.fromARGB(138, 18, 18, 18);
const textGrey = Color.fromARGB(136, 68, 68, 68);
const bgcolor = Color.fromRGBO(217, 217, 217, 1);

const drawercolor = Color.fromARGB(46, 101, 101, 101);
const gradientColor = LinearGradient(
  colors: [
    Color.fromRGBO(19, 131, 149, 1),
    Color.fromRGBO(88, 186, 78, 1),
  ],
  begin: Alignment.centerRight,
  end: Alignment.centerLeft,
);
const sweepGradient = SweepGradient(colors: [
  Color.fromRGBO(19, 131, 149, 1),
  Color.fromRGBO(88, 186, 78, 1),
], stops: [
  0.0,
  1.0
]);

const loginbutton = [
  Color.fromRGBO(88, 186, 78, 1),
  Color.fromRGBO(19, 131, 149, 1)
];
const InnactiveLoginbutton = [
  Color.fromRGBO(89, 186, 78, 0.242),
  Color.fromRGBO(19, 131, 149, 0.242)
];
//...................................................................................

const bluee = Color.fromARGB(255, 3, 134, 241);
Color getStatusColor(String status) {
  switch (status) {
    case "SELECTED":
      return const Color.fromARGB(255, 118, 198, 109);
    case "Apply for this Job":
      return Colors.teal;
    case "REJECTED":
      return Colors.red;
    case "SUBMITTED":
      return bluee;
    default:
      return const Color.fromARGB(
          198, 0, 0, 0); // Default color if none of the cases match
  }
}

// Color getTxtColor(String status) {
//   switch (status) {
//     case "SELECTED":
//       return white;
//     case "Apply for this Job":
//       return white;
//     case "REJECTED":
//       return white;
//     case "Submitted":
//       return black;
//     default:
//       return white;
//   }
// }
