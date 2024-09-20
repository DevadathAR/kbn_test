import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scaleAnimation = Tween<double>(begin: 1, end: 0.6).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: 0,
            bottom: 0,
            left: isCollapsed ? 0 : 200, // Adjust position when sidebar is shown
            right: isCollapsed ? 0 : -200, // Adjust position when sidebar is shown
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Center(
                child: Text('Main Content'),
              ),
            ),
          ),

          // Custom Menu Button
          Positioned(
            top: 40, // Adjust the position for the menu button
            left: 16,
            child: IconButton(
              icon: Icon(Icons.menu, size: 30),
              onPressed: () {
                setState(() {
                  isCollapsed = !isCollapsed;
                  isCollapsed ? _controller.reverse() : _controller.forward();
                });
              },
            ),
          ),

          // Sidebar (only show when menu button is pressed)
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: 80, // Place the sidebar just below the menu button
            bottom: 0,
            left: isCollapsed ? -200 : 0, // Hide sidebar when collapsed
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
                color: tealblue,
              ),
              child: ListView(
                padding: EdgeInsets.only(top: 20), // Adjust the sidebar content padding
                children: [
                  ListTile(title: Text('Dashboard')),
                  ListTile(title: Text('Profile')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
