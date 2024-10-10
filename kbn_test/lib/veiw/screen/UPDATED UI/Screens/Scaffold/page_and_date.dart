import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:intl/intl.dart';

class PageAndDate extends StatefulWidget {
  final String pageLabel;
  final String currentPage;

  const PageAndDate({super.key, required this.pageLabel, required this.currentPage});

  @override
  _PageAndDateState createState() => _PageAndDateState();
}

class _PageAndDateState extends State<PageAndDate> {
  DateTime selectedMonth = DateTime.now();  // Initial date set to current month
  String selectedMonthStr = '';             // Formatted month-year string

  @override
  void initState() {
    super.initState();
    // Initialize to display the current month in 'MM-yyyy' format
    selectedMonthStr = DateFormat('MM-yyyy').format(selectedMonth);
  }

  Future<void> _pickMonth() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedMonth,       // Initially show the current month
      firstDate: DateTime(2000),        // Set the range from 2000 to 2100
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime date) {
        // You can limit the selectable dates here if needed.
        return true;
      },
      helpText: 'Select Month',         // Help text in the date picker
      fieldLabelText: 'Month',
    );

    if (pickedDate != null) {
      // Update the selected month and year after user picks a new date
      setState(() {
        selectedMonth = pickedDate;
        selectedMonthStr = DateFormat('MM-yyyy').format(selectedMonth);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                        ),
                      ],
                    ),
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
                  widget.pageLabel,
                  style: AppTextStyle.sixteen_w400_black,
                ),
                // Calendar to select month and year
                if (widget. currentPage!="Terms"&&widget.currentPage!="Profile")
                  GestureDetector(
                    onTap: _pickMonth, // Trigger the month picker on tap
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 5, right: 5),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.85),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                          color: white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Image(image: AssetImage(calenderPng)),
                          const SizedBox(width: 2),
                          Text(
                            selectedMonthStr, // Display the selected month
                            style: AppTextStyle.normalText,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
