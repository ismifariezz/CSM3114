import 'package:flutter/material.dart';
import 'package:travel_apps/screens/question_screen.dart';
import 'package:travel_apps/screens/signup_screen.dart';
import '../screens/profile_screen.dart';

class CustomDrawer extends StatefulWidget {
  final String username;

  const CustomDrawer({super.key, required this.username});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    initProfileScreen();
    super.initState();
  }

  void initProfileScreen() {
    ProfileScreen(username: widget.username);
  }

  void _logout(BuildContext context) {
    // Clear navigation history and navigate to the login screen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      child: ListView(
        children: [
          const SizedBox(
            height: 100.0,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF3B5998)),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ProfileScreen(username: widget.username);
                },
              ));
            },
            leading: Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
          ListTile(
            title: Text('History'),
            onTap: () {},
            leading: Icon(
              Icons.history,
              color: Colors.black,
            ),
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {},
            leading: Icon(Icons.settings, color: Colors.black),
          ),
          ListTile(
            title: Text('FAQ'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return FAQScreen(username: widget.username);
                },
              ));
            },
            leading: Icon(Icons.question_answer_outlined, color: Colors.black),
          ),
          ListTile(
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              _logout(context);
            },
            leading: Icon(Icons.logout, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
