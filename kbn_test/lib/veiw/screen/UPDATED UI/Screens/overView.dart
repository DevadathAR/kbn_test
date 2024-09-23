import 'package:flutter/cupertino.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/chartWidget.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/messageWidget.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/payResult.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/simpleTable.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/verticalTable.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // first column
        Expanded(
          flex: 1,
          child: Column(
            children: [
              ChartsScreen(),
              SizedBox(height: 10),
              HorizontalTable(),
            ],
          ),
        ),
        SizedBox(width: 10),
        // second table
        Expanded(
          flex: 1,
          child: VerticalTable(),
        ),
        // 3rd column
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                MessageWidget(),
                SizedBox(height: 10),
                PayResult(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
