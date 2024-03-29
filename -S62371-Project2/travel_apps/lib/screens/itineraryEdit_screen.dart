import 'package:flutter/material.dart';
import 'package:travel_apps/models/itinerary.dart';
import '../models/activity_model.dart';
//import '../models/place_item.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ItineraryEditScreen extends StatefulWidget {
  final String id;
  final String countryName;
  final String username;
  final DateTime fromDate;
  final DateTime toDate;
  // final String tableKey;

  const ItineraryEditScreen(
      this.id, this.countryName, this.username, this.fromDate, this.toDate);

  @override
  _ItineraryEditScreenState createState() => _ItineraryEditScreenState();
}

class _ItineraryEditScreenState extends State<ItineraryEditScreen>
    with SingleTickerProviderStateMixin {
  String selectedTransportation = 'Rental Car';
  String selectedHome = 'Homestay'; // Default value
  List<String> selectedActivities = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2, // Two tabs: Transportation and Activities
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get activities based on the selected country
    List<String>? activities = ActivityModel.activities[widget.countryName];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3B5998),
        title: Text('Edit Itinerary'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Transportation & Home'),
            Tab(text: 'Activities'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Transportation Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Choose Transportation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3B5998),
                  ),
                ),
                // Dropdown for transportation
                DropdownButton<String>(
                  value: selectedTransportation,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 0,
                  isExpanded: true,
                  style: TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTransportation = newValue!;
                    });
                  },
                  items: <String>[
                    'Rental Car',
                    'Public Transportation',
                    'Taxi',
                    // Add more transportation options as needed
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                // Dropdown for home choices
                Text(
                  'Choose Home',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3B5998),
                  ),
                ),
                DropdownButton<String>(
                  value: selectedHome,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 0,
                  isExpanded: true,
                  style: TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedHome = newValue!;
                    });
                  },
                  items: <String>[
                    'Homestay',
                    'Hotel',
                    'Shalet',
                    // Add more home choices as needed
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Information Saved'),
                      ),
                    );
                  },
                  child: Text('Save'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3B5998)),
                ),
              ],
            ),
          ),
          // Activities Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Choose Activities',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color(0xFF3B5998),
                  ),
                ),
                SizedBox(height: 16),
                // Activities checkboxes
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: activities!
                      .map(
                        (activity) => CheckboxListTile(
                          title: Text(activity),
                          value: selectedActivities.contains(activity),
                          onChanged: (bool? isChecked) {
                            setState(() {
                              if (isChecked != null) {
                                if (isChecked) {
                                  selectedActivities.add(activity);
                                } else {
                                  selectedActivities.remove(activity);
                                }
                              }
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    updateItineraryData();
                    Navigator.pop(
                        context,
                        Itinerary(
                            transportation: selectedTransportation,
                            home: selectedHome,
                            activities: selectedActivities));
                  },
                  child: Text('Save'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3B5998)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateItineraryData() async {
    final url = Uri.https(
      'travel-planner-32bb6-default-rtdb.asia-southeast1.firebasedatabase.app',
      'UserData/${widget.username}/RegisteredPlace/${widget.id}.json',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = json.decode(response.body);

      if (data != null && data.isNotEmpty) {
        // Assuming 'Itinerary' is a field in your existing data
        if (data.containsKey('Itinerary')) {
          // Update the 'Itinerary' field
          data['Itinerary'] = {
            'transportation': selectedTransportation,
            'home': selectedHome,
            'activities': selectedActivities,
            // Add other properties as needed
          };

          // Send the updated data back to the server using PUT request
          final updateResponse = await http.put(
            url,
            body: json.encode(data),
          );

          if (updateResponse.statusCode != 200) {
            print('Failed to update Itinerary data');
          }
        } else {
          print('The key "Itinerari" does not exist in the data');
        }
      } else {
        print('Data is empty or non-existent');
      }
    } else {
      print('Failed to load data');
    }
  }
}

//i want the page  use TabController widget,  have 3 tabs Malaysia, china India, and will show list of the activities based on the country with price and make check box to choose the activity and to sum the price
