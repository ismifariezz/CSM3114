import 'package:flutter/material.dart';
import 'package:travel_apps/models/itinerary.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/place_item.dart';

class ItineraryDetailScreen extends StatefulWidget {
  final String username;
  final String id;

  ItineraryDetailScreen(this.id, this.username);

  @override
  State<ItineraryDetailScreen> createState() => _ItineraryDetailScreenState();
}

class _ItineraryDetailScreenState extends State<ItineraryDetailScreen> {
  List<SelectedCountry> selectedCoutries = [];
  String? _error;

  void fetchData() async {
    final url = Uri.https(
        'travel-planner-32bb6-default-rtdb.asia-southeast1.firebasedatabase.app',
        'Signup/${widget.username}/RegisteredPlace/${widget.id}.json');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = json.decode(response.body);

        if (data == null || data.isEmpty) {
          print('No data found.');
          // Handle the case where data is empty or non-existent
          return;
        }

        DateTime _parseDateTime(String dateString) {
          try {
            return DateTime.parse(dateString);
          } catch (e) {
            print('Error parsing date: $dateString');
            return DateTime.now();
          }
        }

        final List<SelectedCountry> loadedCountry = [];
        data.forEach((key, value) {
          loadedCountry.add(SelectedCountry(
            country: value['Country'],
            fromDate: _parseDateTime(value['FromDate']),
            toDate: _parseDateTime(value['ToDate']),
            itinerary: Itinerary.fromJson(value['Itinerary'] ?? {}),
          ));
        });

        // Update the state with the retrieved data
        setState(() {
          selectedCoutries = loadedCountry;
        });
        //print('countriesList = ${countriesList}');
        for (final country in selectedCoutries) {
          print('Country: ${country.country}');
          print('From Date: ${_formatDate(country.fromDate)}');
          print('To Date: ${_formatDate(country.toDate)}');
          print('Itinerary: ${country.itinerary}');
          print('-------------------------');
        }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Itinerary Details'),
      ),
      body: _error != null
          ? Center(child: Text(_error!))
          : selectedCoutries.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: selectedCoutries.length,
                  itemBuilder: (context, index) {
                    final country = selectedCoutries[index];
                    return Card(
                      child: ListTile(
                        title: Text('Country: ${country.country}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('From: ${_formatDate(country.fromDate)}'),
                            Text('To: ${_formatDate(country.toDate)}'),
                            Text('Itinerary: ${country.itinerary}'),
                            // Add additional information as needed
                          ],
                        ),
                      ),
                    );
                  },
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
}
