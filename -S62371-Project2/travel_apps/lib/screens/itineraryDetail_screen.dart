import 'package:flutter/material.dart';
import 'package:travel_apps/models/itinerary.dart';

class ItineraryDetailScreen extends StatelessWidget {
  final String username;
  final String country;
  final DateTime fromDate;
  final DateTime toDate;
  final Itinerary itinerary;

  ItineraryDetailScreen(
      this.username, this.country, this.fromDate, this.toDate, this.itinerary);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3B5998),
        title: Text('Itinerary Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Country: $country',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('From: ${_formatDate(fromDate)}'),
            Text('Until: ${_formatDate(toDate)}'),
            SizedBox(height: 16.0),
            Text(
              'Itinerary Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF3B5998),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTableRow('Field', 'Value', isHeader: true),
                  _buildTableRow('Transportation', itinerary.transportation),
                  _buildTableRow('Home', itinerary.home),
                  _buildTableRow(
                    'Activities',
                    itinerary.activities
                        .map((activity) => '- $activity')
                        .join('\n'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow(String field, String value, {bool isHeader = false}) {
    return Container(
      color: isHeader ? Color(0xFF3B5998) : Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                field,
                style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  color: isHeader ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value),
            ),
          ),
        ],
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
