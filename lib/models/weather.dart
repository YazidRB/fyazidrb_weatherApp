class Weather {
  final String cityName;
  final String mainCondition;
  final double temp;

  Weather(
      {required this.cityName,
      required this.mainCondition,
      required this.temp});

  factory Weather.fromJson(Map<String, dynamic> json) {
    print("=====================================");
    print(json);
    print("=====================================");
    return Weather(
        cityName: json["name"],
        mainCondition: json["weather"][0]["main"],
        temp: ((json["main"]["temp"] - 273.15)));
  }
}
