// import 'package:flutter/material.dart';
// import 'package:kbn_test/utilities/assets_path.dart';
// import 'package:kbn_test/utilities/colors.dart';
// import 'package:kbn_test/utilities/text_style.dart';

// class HorizontalCards extends StatelessWidget {
//   const HorizontalCards({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, String>> cardData = [
//       {
//         'title': "Positioned",
//         'subTitle': "Company position on this month",
//       },
//       {
//         'title': "82 K",
//         'subTitle': "Applicants applied on this month",
//       },
//       {
//         'title': "30 K",
//         'subTitle': "Applicants have got jobs",
//       },
//       {
//         'title': "82K",
//         'subTitle': "Applicants applied on this month",
//       },
//       {
//         'title': "65%",
//         'subTitle': "More applicants have got Python jobs",
//       },
//     ];
//     return Container(
//         alignment: Alignment.center,
//         decoration: ShapeDecoration(
//           image: const DecorationImage(
//             image: AssetImage(overViewBg),
//             fit: BoxFit.cover,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         child: const Padding(
//           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
//           child: Wrap(
//             spacing: 10,
//             runSpacing: 10,
//             alignment: WrapAlignment.spaceAround,
//             children: [
//               cards(
//                 title: "Positioned",
//                 subTitle: "COmpany position on this month",
//               ),
//               SizedBox(width: 5),
//               cards(
//                 title: "82 K",
//                 subTitle: "Applicants applied on this month",
//               ),
//               SizedBox(width: 5),
//               cards(
//                 title: "30 k",
//                 subTitle: "Applicants has got job",
//               ),
//               SizedBox(width: 5),
//               cards(
//                 title: "82K",
//                 subTitle: "Applicants applied on this month",
//               ),
//               SizedBox(width: 5),
//               cards(
//                 title: "65%",
//                 subTitle: "More applicants has got python jobs",
//               ),
//             ],
//           ),
//         ));
//   }
// }

// class cards extends StatelessWidget {
//   final String title;
//   final String subTitle;
//   const cards({
//     super.key,
//     required this.title,
//     required this.subTitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       height: 100,
//       width: 180,
//       decoration: ShapeDecoration(
//         // color: const Color(0xFFFDFDFD),
//         color: white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title, style: AppTextStyle.thirty_w500),
//           const Spacer(),
//           Text(subTitle,
//               textAlign: TextAlign.start, style: AppTextStyle.bodytext_12),
//         ],
//       ),
//     );
//   }
// }
