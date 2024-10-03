import 'package:flutter/material.dart';
import 'package:kbn_test/UPDATED%20UI/Screens/jobScreen.dart';
import 'package:kbn_test/UPDATED%20UI/Screens/transactionScreen.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/showAll_bTn.dart';
import 'package:kbn_test/utilities/colors.dart';

class PayResult extends StatelessWidget {
  const PayResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
              Expanded(
                child: _buildCard(info: "1250+GST",description: 
                    'paid on date'),
              ),
              const SizedBox(width: 10), // Space between the cards
              Expanded(
                child: _buildCard( info: 'Success',description: 
                    'previous payment date'),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Bottom Show All Button
          ShowAllBtn(onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const CompanyTransation();
            },));
          },title: "Show All",)
        ],
      ),
    );
  }

  // Card Widget for the number and description
  Widget _buildCard({info, description}) {
    return Container(
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
      child:  Column(
        children: [ Align(alignment: Alignment.topLeft, child: Text(" to Admin,")),
          Text(
            info,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15, // Increase font size for emphasis
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12), // Adjust font size for readability
          ),
        ],
      ),
    );
  }
}

// Widget _companyFrontPagePaymentInfo(){
//   return Expanded(
//                 child: _buildCard('Number',
//                     'of companies who completed transaction of this month'),
//               );
// }