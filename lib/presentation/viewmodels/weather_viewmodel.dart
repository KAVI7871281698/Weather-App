import 'package:flutter/material.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/usecases/get_weather_usecase.dart';

class WeatherViewModel extends ChangeNotifier {
  final GetWeatherUseCase getWeatherUseCase;

  WeatherViewModel(this.getWeatherUseCase);

  WeatherEntity? weather;
  bool isLoading = false;
  String? error;

  Future<void> loadWeather(String city) async {
    if (city.isEmpty) return;

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      weather = await getWeatherUseCase(city);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
