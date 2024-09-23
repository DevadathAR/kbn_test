import 'package:flutter/cupertino.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Screens/overView.dart';
import 'package:kbn_test/veiw/screen/UPDATED%20UI/Widgets/scaffoldBuilder.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldBuilder(child: OverviewScreen());
  }
}
