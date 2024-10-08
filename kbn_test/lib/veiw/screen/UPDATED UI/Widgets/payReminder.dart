import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/showAll_bTn.dart';

class PayRemainder extends StatelessWidget {
  const PayRemainder({super.key});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    final dateFormat = DateFormat("dd MMM yyyy");

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
                child: _buildCard(
                  title: "to admin ,",
                  mainText: "15,000",
                  footerText: "+ GST\n date\n${dateFormat.format(date)}",
                  isAmount: true,
                ),
              ),
              const SizedBox(width: 10), // Space between the cards
              Expanded(
                child: _buildCard(
                  title: "to admin ,",
                  mainText: "Succesfull",
                  footerText: "+ GST\n date\n${dateFormat.format(date)}",
                  isAmount: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Bottom Show All Button
          ShowAllBtn(
            onTap: () {
              // Add your desired functionality here
            },
          ),
        ],
      ),
    );
  }

  // Card Widget for the number and description
  Widget _buildCard(
      {required String title,
      required String mainText,
      required String footerText,
      required bool isAmount}) {
    return Container(
      height: 150, // Increased height to fit content
      width: 140, // Increased width for better display
      padding: const EdgeInsets.all(10), // Added padding for inner spacing
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title (e.g. "to admin ,")
          Text(
            title,
            style: const TextStyle(
              fontSize: 12, // Smaller font for the title
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),

          // Main content (e.g. "15,000" or "Successful")
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              mainText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isAmount ? 24 : 20, // Larger font for the amount
                color:
                    isAmount ? Colors.green : Colors.black, // Green for amount
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Footer text (e.g. "+ GST" or date)
          Text(
            footerText,
            style: const TextStyle(
              fontSize: 12, // Smaller font for the footer text
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
