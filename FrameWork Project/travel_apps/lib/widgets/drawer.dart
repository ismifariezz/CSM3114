import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      backgroundColor: Colors.green[100],
      child: ListView(
        children: [
          const SizedBox(
            height: 100.0,
            child: const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text('Menu'),
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
              color: Colors.green,
            ),
          ),
          ListTile(
            title: Text('History'),
            onTap: () {},
            leading: Icon(
              Icons.history,
              color: Colors.green,
            ),
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {},
            leading: Icon(Icons.settings, color: Colors.green),
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ));
            },
            leading: Icon(Icons.logout, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
