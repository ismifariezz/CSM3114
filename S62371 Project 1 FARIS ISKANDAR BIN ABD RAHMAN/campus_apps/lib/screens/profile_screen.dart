import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              // Replace with the user's profile picture
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            SizedBox(height: 20),
            Text(
              'Faris Iskandar bin Abd Rahman', // Replace with the user's name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Computer Science (Mobile Computing)', // Replace with the user's major
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(
                'riezz021@gmail.com',
                style: TextStyle(fontWeight: FontWeight.bold),
              ), // Replace with the user's email
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('+60 11 23612582',
                  style: TextStyle(
                      fontWeight: FontWeight
                          .bold)), // Replace with the user's phone number
            ),
            // Add more ListTile widgets for additional user information
          ],
        ),
      ),
    );
  }
}
