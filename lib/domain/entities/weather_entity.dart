class WeatherEntity {
  final String city;
  final double temperature;
  final String condition;
  final int humidity;
  final double windSpeed;
  final String icon;

  WeatherEntity({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
  });
}
