import 'package:flutter/material.dart';
import 'package:fyazidrb_weatherapp/Services/weather_service.dart';
import 'package:fyazidrb_weatherapp/models/weather.dart';
import 'package:fyazidrb_weatherapp/themes/themeprovider.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // API KEY of the weather service
  static const _apiKey = 'fea8d3ce07cdcbc6ed8f725e123d828c';

  // return the Weather animation depend on the main condition
  String getWeatherAnimation(String? mainCondition) {
    switch (mainCondition?.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return 'assets/cloud.gif'; //cloud
      case "rain":
      case "drizzle":
      case "shower rain":
        return 'assets/rain.png'; //rain
      case "thunderstorm":
        return 'assets/thunder.png'; //thunderstorm
      case "clear":
        return 'assets/clear.gif'; //clear
      default:
        return 'assets/clear.gif'; // clear
    }
  }

  // weather instance
  Weather? _weather;

  // feath the weather of the current city
  _fetchWeather() async {
    final String cityName =
        await Weatherservice(apiKey: _apiKey).getCurrentCity();

    Weather weather =
        await Weatherservice(apiKey: _apiKey).getWeather(cityName);

    setState(() {
      _weather = weather;
    });
  }

  @override
  void initState() {
    // get the weather of the city
    _fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Themeprovider>(
      builder: (context, value, child) => Scaffold(
        body: Center(
          child: _weather == null
              // loading for the wearher inforamtions
              ? const CircularProgressIndicator()
              // display the weather in the UI
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Location City Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.grey[700],
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _weather?.cityName ?? "noCityName",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    // Main Condition Image Animation
                    Center(
                      child: Image.asset(
                        getWeatherAnimation(_weather!.mainCondition),
                      ),
                    ),
                    // Temp Value
                    Text(
                      '${_weather?.temp.round().toString() ?? 0.0.toString()} °C',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    // Main Condition Text
                    Text(_weather?.mainCondition ?? "noCondition",
                        style: Theme.of(context).textTheme.titleLarge),
                    // Theme Toggle Button
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.grey.shade600,
                          )),
                      child: IconButton(
                          onPressed: () {
                            // change the theme
                            value.toggleTheme();
                          },
                          icon: value.isDark()
                              ? const Icon(
                                  Icons.nightlight_round_sharp,
                                  size: 38,
                                  color: Colors.black,
                                )
                              : const Icon(
                                  Icons.sunny,
                                  size: 38,
                                )),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
