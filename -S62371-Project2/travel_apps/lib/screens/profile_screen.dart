import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String username;

  ProfileScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3B5998),
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(
                'assets/images/login.jpg',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Faris Iskandar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'riezz021@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(username: username),
                  ),
                );
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFF3B5998)),
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 16),
            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Location: New York, USA'),
            ),
            const ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Member Since: January 2020'),
            ),
            const ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Date of Birth: January 1, 1990'),
            ),
            const ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Interests: Travel, Photography'),
            ),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text(
                  'Bio: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus bibendum mauris vel efficitur vulputate.'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  final String username;

  EditProfileScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                'https://source.unsplash.com/random/200x200',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement image upload functionality
              },
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement update profile functionality
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
