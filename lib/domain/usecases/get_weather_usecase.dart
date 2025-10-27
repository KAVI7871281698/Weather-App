import '../../data/repositories/weather_repository.dart';
import '../entities/weather_entity.dart';

class GetWeatherUseCase {
  final WeatherRepository repository;

  GetWeatherUseCase(this.repository);

  Future<WeatherEntity> call(String city) async {
    return await repository.fetchWeather(city);
  }
}
