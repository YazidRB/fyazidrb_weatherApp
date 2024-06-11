import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_first_app/Services/weatherService.dart';
import 'package:my_first_app/models/weather.dart';
import 'package:my_first_app/themes/themeprovider.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static const _apiKey = 'fea8d3ce07cdcbc6ed8f725e123d828c';

  String getWeatherAnimation(String? mainCondition) {
    switch (mainCondition?.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return 'assets/cloud.json'; //cloud
      case "rain":
      case "drizzle":
      case "shower rain":
        return 'assets/rain.json'; //rain
      case "thunderstorm":
        return 'assets/thunder.json'; //thunderstorm
      case "clear":
        return 'assets/clear.json'; //clear
      default:
        return 'assets/clear.json'; // clear
    }
  }

  Weather? _weather;

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
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Themeprovider>(
      builder: (context, value, child) => Scaffold(
        body: Center(
          child: _weather == null
              ? CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.grey[700],
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _weather?.cityName ?? "noCityName",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    Center(
                      child: Lottie.asset(
                        getWeatherAnimation(_weather!.mainCondition),
                      ),
                    ),
                    Text(
                      (_weather?.temp.round().toString() ?? 0.0.toString()) +
                          ' °C',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(_weather?.mainCondition ?? "noCondition",
                        style: Theme.of(context).textTheme.titleLarge),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.grey.shade600,
                          )),
                      child: IconButton(
                          onPressed: () {
                            value.toggleTheme();
                          },
                          icon: value.isDark()
                              ? Icon(
                                  Icons.nightlight_round_sharp,
                                  size: 38,
                                  color: Colors.black,
                                )
                              : Icon(
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
