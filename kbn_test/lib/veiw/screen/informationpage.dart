import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/widgets/side_navbar.dart';

class Informationpage extends StatelessWidget {
  const Informationpage({super.key});

  @override
  Widget build(BuildContext context) {
        Size size= MediaQuery.of(context).size;

    
    return Scaffold(
      body: Row(
        children: [SideNavBar(context,viewinfo: black),
          
          Container(
            height: size.height*1,
            width: size.width*1-230,
            color: black,
          )
        ],
      ),
    );
  }
}
