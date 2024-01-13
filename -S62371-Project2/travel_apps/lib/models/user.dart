import 'package:travel_apps/models/place_item.dart';

class user {
  final String id;
  final String username;
  final String password;
  late RegisteredCountry registeredCountry;

  user(
      {required this.id,
      required this.username,
      required this.password,
      required this.registeredCountry});
}
