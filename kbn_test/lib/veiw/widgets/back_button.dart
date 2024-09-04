import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';

Widget GoBack(context, {backpage}) {
  Size size = MediaQuery.of(context).size;

  return Column(
    children: [
      SizedBox(
        height: size.height * 0.2,
      ),


      
      Padding(
          padding: EdgeInsets.only(left: 20),
          child: GestureDetector(onTap: () {
            Navigator.push(context, MaterialPageRoute(builder:    (context) {
              return backpage;
            },));
          },child: Icon(Icons.arrow_back_ios_sharp))



          // IconButton(
          // onPressed: () {
          //   Navigator.push(context, MaterialPageRoute(
          //     builder: (context) {
          //       return backpage;
          //     },
          //   ));
          // },
          // icon: Icon(Icons.arrow_back_ios_sharp),
          // color: black,
          // ),
          ),
    ],
  );
}
