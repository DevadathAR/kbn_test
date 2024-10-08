import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:intl/intl.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/jobScreen.dart';

class PageAndDate extends StatelessWidget {
  final String pageLabel;

  const PageAndDate({super.key, required this.pageLabel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DateTime now = DateTime.now();
    final DateTime nextMonth = DateTime(now.year, now.month + 1);

    // Formatting dates to 'd-M-yy'
    final String currentMonth = DateFormat('1-MM-yyyy').format(now);
    final String nextMonthStr = DateFormat('1-MM-yyyy').format(nextMonth);

    return SizedBox(
      width: size.width * 1,
      child: Column(
        children: [
          if (size.width < 900)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: GestureDetector(
                    onTap: () {
                      // This will open the drawer programmatically
                      Scaffold.of(context).openDrawer();
                    },
                    child: const Row(
                      children: [
                        Image(
                          image: AssetImage(filterPng),
                          color: black,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Menu",
                          style: AppTextStyle.sixteen_w400_black,
                        )
                      ],
                    ),
                  ),
                ),
                // Container(
                //   width: 75,
                //   padding: const EdgeInsets.only(bottom: 5, right: 5),
                //   color: none,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       GestureDetector(
                //         onTap: () {
                //           _openSearchModal(context); // Open search modal
                //         },
                //         child: Container(
                //           height: 30,
                //           width: 30,
                //           decoration: BoxDecoration(
                //               borderRadius:
                //                   const BorderRadius.all(Radius.circular(8)),
                //               border: Border.all(color: black)),
                //           child: const Icon(
                //             Icons.search,
                //             color: black,
                //           ),
                //         ),
                //       ),
                //       const SizedBox(width: 8),
                //       GestureDetector(onTap: () {
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => CompanyJobpage()),
                //             );
                //           },
                //         child: Container(
                //           height: 30,
                //           width: 30,
                //           decoration: BoxDecoration(
                //               borderRadius:
                //                   const BorderRadius.all(Radius.circular(8)),
                //               color: tealblue,
                //               border: Border.all(color: black)),
                //           child: const Center(
                //             child: Text(
                //               '+',
                //               style: AppTextStyle.fifteenW500,
                //             ),
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pageLabel,
                  style: AppTextStyle.sixteen_w400_black,
                ),
                // Calendar
                if (size.width > 900&&pageLabel =="Overview")
                  Container(
                    padding: const EdgeInsets.only(bottom: 5, right: 5),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.85),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        color: white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Image(image: AssetImage(calenderPng)),
                        const SizedBox(width: 2),
                        Text(
                          '$currentMonth / $nextMonthStr',
                          style: AppTextStyle.normalText,
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openSearchModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Search",
                style: AppTextStyle.twentyW400,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter search query',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onSubmitted: (query) {
                  // Handle search logic here
                  print('Searching for: $query');
                  Navigator.pop(context); // Close the modal after search
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close modal if user cancels
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }
}
