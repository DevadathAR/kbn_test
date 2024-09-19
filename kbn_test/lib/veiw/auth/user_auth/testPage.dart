// Widget bgWidget({mobBg,img, hight}) {
//   return LayoutBuilder(builder: (context, constraints) {
//     // Adjust width and padding based on screen width
//     double width = constraints.maxWidth;
//     bool isMobile = width < 600; // For mobile devices
//     return Container(
//       // color: const Color.fromRGBO(217, 217, 217, 1),
//       child: Align(
//           alignment: isMobile ? Alignment.center : Alignment.centerRight,
//           child: Padding(
//             padding: EdgeInsets.only(
//               top: isMobile ? 10 : 30.0,
//               right: isMobile ? 0 : 30, // No right padding on mobile
//               bottom: isMobile ? 10 : 30.0,
//               left: isMobile ? 0 : 0,
//             ),
//             child: SizedBox(
//               width: width,
//               height: hight,
//               child: isMobile
//                   ? Image(
//                       image: AssetImage(mobBg),
//                     )
//                   : Image(
//                       image: AssetImage(img),
//                     ),
//             ),
//           )),
//     );
//   });
// }
