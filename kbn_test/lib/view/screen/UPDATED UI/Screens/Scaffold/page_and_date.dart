import 'package:flutter/material.dart';
import 'package:kbn_test/service/apiServices.dart';
import 'package:kbn_test/utilities/assets_path.dart';
import 'package:kbn_test/utilities/colors.dart';
import 'package:kbn_test/utilities/text_style.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageAndDate extends StatefulWidget {
  final String pageLabel;
  final String currentPage;
  final VoidCallback onMonthSelect;

  const PageAndDate(
      {super.key,
      required this.pageLabel,
      required this.currentPage,
      required this.onMonthSelect});

  @override
  _PageAndDateState createState() => _PageAndDateState();
}

class _PageAndDateState extends State<PageAndDate> {
  DateTime selectedMonth = DateTime.now(); // Initial date set to current month
  String selectedMonthStr = ''; // Formatted month-year string
  bool isLoading = true; // Add this in your state

  @override
  void initState() {
    super.initState();
    // Initialize to display the current month in 'MM-yyyy' format
    _loadSelectedMonth();
  }

  Future<void> _loadSelectedMonth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int month = prefs.getInt('selectedMonth') ?? DateTime.now().month;
    int year = prefs.getInt('selectedYear') ?? DateTime.now().year;

    setState(() {
      selectedMonth = DateTime(year, month);
      selectedMonthStr = DateFormat('MM-yyyy').format(selectedMonth);
      isLoading = false; // Data has loaded, remove the loading state
    });
  }

  Future<void> _pickMonth() async {
    DateTime? pickedMonth = await showMonthYearPicker(
      context: context,
      initialDate: selectedMonth,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedMonth != null) {
      setState(() {
        selectedMonth = pickedMonth;
        selectedMonthStr = DateFormat('MM-yyyy').format(selectedMonth);
      });

      // Save the selected month and year to SharedPreferences
      await _saveSelectedMonth(selectedMonth.month, selectedMonth.year);
              widget.onMonthSelect();

    }
  }

  Future<void> _saveSelectedMonth(int month, int year) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedMonth', month);
    await prefs.setInt('selectedYear', year);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 1,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show a loader while loading
          : Column(
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
                      if (widget.currentPage != "Terms" &&
                          widget.currentPage != "Profile")
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
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
