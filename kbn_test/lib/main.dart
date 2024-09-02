import 'package:flutter/material.dart';
import 'package:kbn_test/veiw/auth/login.dart';
import 'package:kbn_test/veiw/screen/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      title: "KBN_Test",
      debugShowCheckedModeBanner: false,
      home:
      LogInPage(),
      // Home()
    );
  }
}
