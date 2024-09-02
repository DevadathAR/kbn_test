import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/widgets/side_navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
        Size size= MediaQuery.of(context).size;

    
    return Scaffold(
      body: Row(
        children: [SideNavBar(context,viewprof: black),
          
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
