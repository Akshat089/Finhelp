import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final double screenHeight;

  const DrawerMenu({super.key, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 207, 207, 207),
      child: ListView(
        children: [
          Image.asset(
            'lib/images/logo.jpg',
            fit: BoxFit.contain,
            height: 100,
            width: 100,
          ),
          SizedBox(height: screenHeight * 0.05),
          _buildDrawerItem(Icons.home, "Home", () {}),
          _buildDrawerItem(Icons.bar_chart, "Statistics", () {}),
          _buildDrawerItem(Icons.person, "View Profile", () {}),
          _buildDrawerItem(Icons.bolt, "Advanced Plans", () {}),
          _buildDrawerItem(Icons.notifications, "Notifications", () {}),
          _buildDrawerItem(Icons.settings, "Settings", () {}),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          onTap: onTap,
        ),
        SizedBox(height: screenHeight * 0.005),
      ],
    );
  }
}

