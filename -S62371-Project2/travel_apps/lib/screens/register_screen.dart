import 'package:flutter/material.dart';
import '../models/place_item.dart';
import '../widgets/drawer.dart';
import '../widgets/date_picker.dart';
import '../widgets/carousel_widget.dart';
import 'home_screen.dart';
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
    'Select Country': [
      'M1.jpg',
      'M2.jpg',
      'M3.jpg',
      'C1.jpg',
      'C2.jpg',
      'C3.jpg',
      'I1.jpg',
      'I2.jpg',
      'I3.jpg'
    ],
    'Malaysia': ['M1.jpg', 'M2.jpg', 'M3.jpg'],
    'China': ['C1.jpg', 'C2.jpg', 'C3.jpg'],
    'India': ['I1.jpg', 'I2.jpg', 'I3.jpg'],
    'Thailand': ['M1.jpg', 'C1.jpg', 'I1.jpg'],
    'Korea': ['M2.jpg', 'C2.jpg', 'I2.jpg'],
    'Japan': ['M3.jpg', 'C3.jpg', 'I3.jpg'],
  };

  List<Map<String, dynamic>> countriesData = [
    {'name': 'Malaysia', 'image': 'M1.jpg'},
    {'name': 'China', 'image': 'C1.jpg'},
    {'name': 'India', 'image': 'I1.jpg'},
  ];

  var country = ['Malaysia', 'China', 'India', 'Thailand', 'Korea', 'Japan'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Register Place',
          style:
              TextStyle(color: Color(0xFF3B5998), fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Color(0xFF3B5998)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SafeArea(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 160,
                            child: ListView.builder(
                                itemCount: 6,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 120,
                                      padding: EdgeInsets.all(20),
                                      margin: EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/M${index + 1}.jpg"),
                                          fit: BoxFit.cover,
                                          opacity: 0.7,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.topRight,
                                            child: Icon(
                                                Icons.bookmark_border_outlined,
                                                color: Colors.white,
                                                size: 25),
                                          ),
                                          Spacer(),
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              country[index],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              )),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      for (int i = 0; i < 6; i++)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                )
                              ]),
                          child: Text(
                            country[i],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        )
                    ],
                  ),
                ),
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
                          'Thailand',
                          'Korea',
                          'Japan'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              textAlign: TextAlign.center,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10),
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
              GestureDetector(
                onTap: () {
                  if (selectedCountry == 'Select Country' ||
                      fromDate == null ||
                      toDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Place has been Registered')),
                    );
                    setState(() {
                      _place();
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HomeScreen(username: widget.username),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Color(0xFF3B5998),
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
              SizedBox(height: 5),
            ],
          ),
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
      'UserData/${widget.username}/RegisteredPlace.json',
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'Country': selectedCountry,
          'FromDate': _formatDate(fromDate),
          'ToDate': _formatDate(toDate),
          'Itinerary': "",
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
