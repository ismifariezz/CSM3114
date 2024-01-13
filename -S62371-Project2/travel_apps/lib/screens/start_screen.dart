import 'package:flutter/material.dart';
import 'package:travel_apps/screens/signup_screen.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3B5998),
        title: Text('Smart Travel Planner'),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF3B5998)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 150),
            Image.asset(
              'assets/images/start.png', // Replace with your actual image path
              height: 120, // Set the height as needed
            ),
            const SizedBox(height: 100),
            const Text(
              'Welcome to Smart Travel Planner',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B5998),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your Ultimate Travel Companion Plan, Explore, and Experience',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF3B5998),
              ),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3B5998),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                fixedSize: const Size(300, 60),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
