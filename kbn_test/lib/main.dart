import 'package:flutter/material.dart';
import 'package:kbn_test/veiw/auth/user_auth/UserLoginPage.dart';
import 'package:kbn_test/veiw/screen/user_screen/UserHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MainApp(isLoggedIn: isLoggedIn));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  const MainApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {

    return   MaterialApp(
      title: "KBN_Test",
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const UserHome() : const UserLoginPage(),
    );
    
  }
}
