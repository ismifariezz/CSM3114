import 'package:flutter/material.dart';
import 'package:travel_apps/models/place_item.dart';
import 'package:travel_apps/screens/register_screen.dart';

import 'itinerary_screen.dart';
import '../widgets/bottom_nav.dart';
import 'question_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _pages;
  List<RegisteredCountry> userRegCountries = [];

  @override
  void initState() {
    initListPages();
    super.initState();
  }

  void initListPages() {
    //print("debug home screen = first index ${userRegCountries[].country}");
    _pages = [
      RegisterScreen(
          username: widget.username, userRegCountries: userRegCountries),
      CreateItineraryScreen(
        username: widget.username,
        //countriesList: userRegCountries,
      ),
      FAQScreen(username: widget.username), // Add other pages as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: _pages,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
