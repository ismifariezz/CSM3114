import 'package:flutter/material.dart';
import 'package:travel_apps/models/itinerary.dart';
import 'package:travel_apps/screens/itineraryEdit_screen.dart';
import '../models/place_item.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/drawer.dart';
import 'itineraryDetail_screen.dart';

class CreateItineraryScreen extends StatefulWidget {
  final String username;

  const CreateItineraryScreen({super.key, required this.username});

  @override
  State<CreateItineraryScreen> createState() => _CreateItineraryScreenState();
}

class _CreateItineraryScreenState extends State<CreateItineraryScreen> {
  List<RegisteredCountry> countriesList = [];
  String? _error;
  @override
  void initState() {
    super.initState();
    fetchData(); // Call fetchData method when the widget is initialized
  }

  void fetchData() async {
    final url = Uri.https(
        'travel-planner-32bb6-default-rtdb.asia-southeast1.firebasedatabase.app',
        'UserData/${widget.username}/RegisteredPlace.json');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = json.decode(response.body);

        if (data == null || data.isEmpty) {
          print('No data found.');
          // Handle the case where data is empty or non-existent
          return;
        }

        int _getMonthIndex(String monthName) {
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
          return months.indexOf(monthName) + 1;
        }

        DateTime _parseDateTime(String dateString) {
          try {
            // Assuming the date format is 'dd MMM yyyy' (e.g., '8 Jan 2024')
            final List<String> parts = dateString.split(' ');
            final int day = int.parse(parts[0]);
            final int month = _getMonthIndex(parts[1]);
            final int year = int.parse(parts[2]);

            return DateTime(year, month, day);
          } catch (e) {
            print('Error parsing date: $dateString');
            return DateTime.now();
          }
        }

        final List<RegisteredCountry> loadedCountry = [];
        data.forEach((key, value) {
          print(
              "Debug itinerary screen => data i want =  ${value['Itinerary']}");
          loadedCountry.add(RegisteredCountry(
            id: key,
            country: value['Country'],
            fromDate: _parseDateTime(value['FromDate']),
            toDate: _parseDateTime(value['ToDate']),
            itinerary: Itinerary.fromJson(value['Itinerary'] ?? {}),
          ));
        });

        // Update the state with the retrieved data
        setState(() {
          countriesList = loadedCountry;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        _error = "Error occurred...! Please Try Again Later";
      });
    }
  }

  void _removeItem(RegisteredCountry item) async {
    // delete item dari list
    setState(() {
      countriesList.remove(item);
    });

    // delete item dari database
    final url = Uri.https(
        'travel-planner-32bb6-default-rtdb.asia-southeast1.firebasedatabase.app',
        'UserData/${widget.username}/RegisteredPlace/${item.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      // handle error
      print('Failed to delete item from the database.');
      // You might want to add the removed item back to the list if deletion fails
      setState(() {
        countriesList.add(item);
      });
    } else {
      print('Successfully Delete');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet'));

    if (countriesList.isNotEmpty) {
      content = Column(
        children: [
          SizedBox(height: 20),
          Text(
            'My Trip',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B5998)),
          ),
          SizedBox(height: 5),
          Divider(thickness: 2),
          Expanded(
            child: ListView.builder(
              itemCount: countriesList.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    if (countriesList[index].itinerary.home == '' ||
                        countriesList[index].itinerary.transportation == '' ||
                        countriesList[index].itinerary.activities.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Create Itinerary First')),
                      );
                    } else {
                      Navigator.push<Itinerary>(context,
                          MaterialPageRoute(builder: (builder) {
                        return ItineraryDetailScreen(
                            widget.username,
                            countriesList[index].country,
                            countriesList[index].fromDate,
                            countriesList[index].toDate,
                            countriesList[index].itinerary);
                      }));
                    }
                  });
                },
                child: Dismissible(
                  onDismissed: (direction) {
                    _removeItem(countriesList[index]);
                  },
                  key: ValueKey(countriesList[index].id),
                  child: ListTile(
                      leading: Icon(
                        Icons.location_city,
                        color: Color(0xFF3B5998),
                        size: 45,
                      ),
                      title: Text(countriesList[index].country),
                      subtitle: Text(
                          'From: ${_formatDate(countriesList[index].fromDate)} to ${_formatDate(countriesList[index].toDate)}'),
                      trailing: IconButton(
                          onPressed: () {
                            Navigator.push<Itinerary>(context,
                                MaterialPageRoute(builder: (builder) {
                              return ItineraryEditScreen(
                                  countriesList[index].id,
                                  countriesList[index].country,
                                  widget.username,
                                  countriesList[index].fromDate,
                                  countriesList[index].toDate);
                            }));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Color(0xFF3B5998),
                          ))),
                ),
              ),
            ),
          ),
          Divider(thickness: 2),
        ],
      );
    }

    if (_error != null) {
      content = Center(child: Text(_error!));
    }
    return Scaffold(
      //backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Color(0xFF3B5998),
        title: Text('Itinerary'),
        actions: [IconButton(onPressed: fetchData, icon: Icon(Icons.refresh))],
      ),
      body: content,
      drawer: CustomDrawer(username: widget.username),
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
}
