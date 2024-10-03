import 'package:flutter/material.dart';
import 'package:kbn_test/UPDATED%20UI/Widgets/drawer.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:intl/intl.dart';

class PageAndDate extends StatelessWidget {
  final String pageLabel;

  PageAndDate({required this.pageLabel});

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
                Container(
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
                          style: AppTextStyle.flitertxtblack,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 75,
                  padding: const EdgeInsets.only(bottom: 5, right: 5),
                  color: none,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _openSearchModal(context); // Open search modal
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(8)),
                              border: Border.all(color: black)),
                          child: const Icon(
                            Icons.search,
                            color: black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(8)),
                            color: tealblue,
                            border: Border.all(color: black)),
                        child: const Center(
                          child: Text(
                            '+',
                            style: AppTextStyle.logoNameText,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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
                  style: AppTextStyle.googletext,
                ),
                // Calendar
                if (size.width > 900)
                  Container(
                    padding: const EdgeInsets.only(bottom: 5, right: 5),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
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
                style: AppTextStyle.googletext,
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
