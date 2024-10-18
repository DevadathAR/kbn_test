// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:kbn_test/service/apiServices.dart';
// import 'package:kbn_test/service/modelClass.dart';
// import 'package:kbn_test/utilities/colors.dart';
// import 'package:kbn_test/utilities/text_style.dart';
// import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/messageScreen.dart';
// import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/showAll_bTn.dart';

// class MessagePageList extends StatelessWidget {
//   final double height;
//   final bool viewReplyButton;
//   final double tileHeight;
//   final double imgSize;
//   final double paddingSeparation;
//   final List<MessagesPageDatum> messagesPageData;

//   const MessagePageList({
//     Key? key,
//     this.height = 500,
//     this.viewReplyButton = true,
//     this.tileHeight = 100,
//     this.imgSize = 30,
//     this.paddingSeparation = 15,
//     required this.messagesPageData,
//   }) : super(key: key);

//   void _showFullMessage(BuildContext context, MessagesPageDatum message) {
// Size size = MediaQuery.of(context).size;

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: none,
//           content: Container(
//             width: size.width*.6,
//             height: 200,
//             decoration: BoxDecoration(
//               boxShadow: [BoxShadow(color: Colors.black)],
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),border: Border.all(color: textGrey)
//             ),
//             child: SingleChildScrollView(
//               child: 
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: ListBody(
//                   children: <Widget>[
//                     Text(message.sender, style: AppTextStyle.thirteenW500),
//                     const SizedBox(height: 10),
//                     Text(message.content, style: AppTextStyle.normalText),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }


//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Container(
//       height: height,
//       width: size.width > 1200 ? (size.width - 200) * .49 : null,
//       decoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(6)), color: white),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           SizedBox(
//             height: viewReplyButton ? height : 235,
//             child: ListView.builder(
//               physics: const BouncingScrollPhysics(),
//               itemCount: messagesPageData.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: EdgeInsets.all(paddingSeparation),
//                   child: GestureDetector(
//                     onTap: viewReplyButton
//                         ? () {
//                             _showFullMessage(context, messagesPageData[index]);
//                           }
//                         : null,
//                     child: Container(
//                       decoration: BoxDecoration(
//                           border:
//                               Border.all(color: Colors.grey.withOpacity(0.5)),
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(6)),
//                           color: white),
//                       height: tileHeight,
//                       child: buildListItem(
//                         context,
//                         name: messagesPageData[index].sender,
//                         description: messagesPageData[index].content,
//                         date: DateFormat('dd-MM-yyyy').format(DateTime.parse(
//                             messagesPageData[index].createdAt.toString())),
//                         viewreplybutton: viewReplyButton,
//                         imgsize: imgSize,
//                         profilepic:messagesPageData[index].profileimg
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           if (!viewReplyButton)
//             Padding(
//               padding: const EdgeInsets.only(right: 5.0, bottom: 5),
//               child: ShowAllBtn(onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return const CompanyMessage();
//                     },
//                   ),
//                 );
//               }),
//             )
//         ],
//       ),
//     );
//   }
// }



// Widget buildListItem(context,{name, description, date, viewreplybutton, imgsize,profilepic}) {

//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//     child: Row(
//       children: [
//         CircleAvatar(backgroundImage:  NetworkImage("${ApiServices.baseUrl}/${profilepic}"),radius: imgsize,),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 name,
//                 style: AppTextStyle.normalText,
//               ),
//               const SizedBox(height: 4),
//               SizedBox(
//                 child: Text(
//                   description,
//                   style: AppTextStyle.twelve_w500,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               )
//             ],
//           ),
//         ),
//         const SizedBox(width: 16),
//         Align(
//             alignment: Alignment.topRight,
//             child: Text(
//               date,
//               style: AppTextStyle.normalText,
//             )),
//         if (viewreplybutton)
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 10, bottom: 10),
//               child: SizedBox(
//                 width: 100,
//                 height: 30,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: tealblue,
//                     shape: RoundedRectangleBorder(
//                       // Creates rounded corner buttons
//                       borderRadius:
//                           BorderRadius.circular(10), // Adjust corner radius
//                     ),
//                   ),
//                   child: const Expanded(
//                     child: Text(
//                       "Replay",
//                       style: TextStyle(color: white),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           )
//       ],
//     ),
//   );
// }