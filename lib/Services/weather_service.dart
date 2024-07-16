import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fyazidrb_weatherapp/models/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Weatherservice {
  // Api Key of the Weather Service
  final String apiKey;
  // The BASEURL of the Weather Service (openweathermap)

  // ignore: constant_identifier_names
  static const String BASEURL = "https://api.openweathermap.org/data/2.5/";

  Weatherservice({required this.apiKey});

  // return the weather of the city
  Future<Weather> getWeather(String cityName) async {
    final json = await http
        .get(Uri.parse("${BASEURL}weather?q=$cityName&appid=$apiKey"));

    return Weather.fromJson((jsonDecode(json.body)));
  }

  // return the current city location of the phone
  Future<String> getCurrentCity() async {
    Position? position;
    // get the services status
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationServiceEnabled == false) {
      return "Service Disable";
    } else {
      // get the permission status
      LocationPermission checkPermission = await Geolocator.checkPermission();
      if (checkPermission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      } else {
        // if permission enabled and the app has permission return the position
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
