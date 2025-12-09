class Weather {
  Weather({
    required this.temperature,
    required this.feelsLike,
    required this.wind,
    required this.description,
    this.humidity,
    this.pressure,
  });

  final double temperature;
  final double feelsLike;
  final double wind;
  final double? humidity;
  final double? pressure;
  final String description;
}

