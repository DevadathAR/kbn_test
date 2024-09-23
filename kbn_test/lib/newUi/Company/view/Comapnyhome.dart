// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:kbn_test/newUi/Company/view/scaffoldbuilder.dart';


// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const ScaffoldBuilder(
//       pageName: "Overview",
//       currentPath: "Overview",
//       child: SizedBox(
//         height: 410,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Wrap(
//             spacing: 10.0, // Space between each widget horizontally
//             runSpacing: 10.0, // Space between each widget vertically
//             children: [
//               // First column (Charts and Horizontal Table)
//               SizedBox(
//                 width: 400, // Adjust the width as necessary
//                 child: Column(
//                   children: [
//                     ChartsScreen(),
//                     SizedBox(height: 10),
//                     HorizontalTable(),
//                   ],
//                 ),
//               ),

//               // Second column (Vertical Table)
//               SizedBox(
//                 width: 400, // Adjust the width as necessary
//                 child: VerticalTable(),
//               ),

//               // Third column (Message and Pay Result)
//               SizedBox(
//                 width: 400, // Adjust the width as necessary
//                 child: Column(
//                   children: [
//                     MessageWidget(),
//                     SizedBox(height: 10),
//                     PayResult(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }