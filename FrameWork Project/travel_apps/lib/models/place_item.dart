import 'package:travel_apps/models/itinerary.dart';

class RegisteredCountry {
  String id;
  String country;
  DateTime fromDate;
  DateTime toDate;
  late Itinerary itinerary;

  RegisteredCountry({
    required this.id,
    required this.country,
    required this.fromDate,
    required this.toDate,
    required this.itinerary,
  });
}

class SelectedCountry {
  String country;
  DateTime fromDate;
  DateTime toDate;
  Itinerary itinerary;

  SelectedCountry(
      {required this.country,
      required this.fromDate,
      required this.toDate,
      required this.itinerary});
}
