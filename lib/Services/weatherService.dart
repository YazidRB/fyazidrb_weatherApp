import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_first_app/models/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Weatherservice {
  final String apiKey;
  static String BASEURL = "https://api.openweathermap.org/data/2.5/";

  Weatherservice({required this.apiKey});

  Future<Weather> getWeather(String cityName) async {
    final json = await http
        .get(Uri.parse("${BASEURL}weather?q=$cityName&appid=$apiKey"));

    return Weather.fromJson((jsonDecode(json.body)));
  }

  Future<String> getCurrentCity() async {
    Position? position;

    if (Geolocator.isLocationServiceEnabled() == false) {
      return "Service Disable";
    } else {
      if (Geolocator.checkPermission() == LocationPermission.denied) {
        await Geolocator.requestPermission();
      } else {
        position = await Geolocator.getCurrentPosition();
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        Placemark place = placemarks[0];
        return place.locality.toString();
      }
    }
    return "";
  }
}
