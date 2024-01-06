import 'package:flutter/material.dart';
import '../models/place_item.dart';
import '../widgets/drawer.dart';
import '../widgets/date_picker.dart';
import '../widgets/carousel_widget.dart';
import 'home_screen.dart';
//import 'itinerary_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  final String username;
  final List<RegisteredCountry> userRegCountries;

  RegisterScreen({required this.username, required this.userRegCountries});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String selectedCountry = 'Select Country';
  DateTime? fromDate;
  DateTime? toDate;

  Map<String, List<String>> countryImages = {
    'Malaysia': ['M1.jpg', 'M2.jpg', 'M3.jpg'],
    'China': ['C1.jpg', 'C2.jpg', 'C3.jpg'],
    'India': ['I1.jpg', 'I2.jpg', 'I3.jpg'],
  };

  // Placeholder data for card widgets
  List<Map<String, dynamic>> countriesData = [
    {'name': 'Malaysia', 'image': 'M1.jpg'},
    {'name': 'China', 'image': 'C1.jpg'},
    {'name': 'India', 'image': 'I1.jpg'},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Register Place',
          style: TextStyle(color: Colors.green),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            // Row of country cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: countriesData
                  .map(
                    (country) => GestureDetector(
                      onTap: () {
                        // TODO: Navigate to country details page
                      },
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              child: Image.asset(
                                'assets/images/${country['image']}',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: Colors.black.withOpacity(0.6),
                              width: 150,
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  country['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 10),
            Divider(thickness: 1, color: Colors.green),
            SizedBox(height: 10),
            Text(
              'Register Country',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 16),
            CountryCarousel(
              selectedCountry: selectedCountry,
              images: countryImages[selectedCountry],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: DropdownButton<String>(
                      value: selectedCountry,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      style: TextStyle(color: Colors.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCountry = newValue!;
                        });
                      },
                      items: <String>[
                        'Select Country',
                        'Malaysia',
                        'China',
                        'India',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      DatePickerWidget(
                        hintText: 'From',
                        selectedDate: fromDate,
                        onDateSelected: (date) {
                          setState(() {
                            fromDate = date;
                          });
                        },
                      ),
                      SizedBox(width: 16),
                      DatePickerWidget(
                        hintText: 'To',
                        selectedDate: toDate,
                        onDateSelected: (date) {
                          setState(() {
                            toDate = date;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Place has been Registered')),
                );
                setState(() {
                  _place();
                });
                //print("debug register screen = first index ${widget.userRegCountries[0].country}");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(username: widget.username),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('Country: $selectedCountry'),
            SizedBox(height: 5),
            Text('From ${_formatDate(fromDate)} to ${_formatDate(toDate)}'),
          ],
        ),
      ),
      drawer: CustomDrawer(
        username: widget.username,
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Select Date';
    }
    return '${date.day} ${_getMonthName(date.month)} ${date.year}';
  }

  String _getMonthName(int month) {
    const List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  void _place() async {
    final url = Uri.https(
      'travel-planner-32bb6-default-rtdb.asia-southeast1.firebasedatabase.app',
      'Signup/${widget.username}/RegisteredPlace.json',
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'Country': selectedCountry,
          'FromDate': _formatDate(fromDate),
          'ToDate': _formatDate(toDate),
          'Itinerary': '',
        },
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('name')) {
        final String newItemId = responseData['name'];
        print('Successfully saved data with ID: $newItemId');

        // Navigate to CreateItineraryScreen and replace the current route
      } else {
        print('Failed to retrieve ID from response');
      }
    } else {
      print('Failed to save data');
    }
  }
}
