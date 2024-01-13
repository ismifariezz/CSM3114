class Itinerary {
  final String transportation;
  final String home;
  final List<String> activities;

  Itinerary({
    required this.transportation,
    required this.home,
    required this.activities,
  });

  factory Itinerary.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return Itinerary(
        transportation: json['transportation'] ?? '',
        home: json['home'] ?? '',
        activities: List<String>.from(json['activities'] ?? []),
      );
    } else if (json is String) {
      // Handle the case where 'Itinerary' is a String
      // You might want to parse the String into appropriate fields
      // For now, let's assume it's a comma-separated list of activities
      final List<String> activities = json.split(',');
      return Itinerary(
        transportation: '',
        home: '',
        activities: activities,
      );
    } else {
      // Handle other cases or return a default Itinerary
      print('Unexpected format for Itinerary field: $json');
      return Itinerary(
        transportation: '',
        home: '',
        activities: [],
      );
    }
  }
}
