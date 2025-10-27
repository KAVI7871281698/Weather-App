import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';
import '../../domain/entities/weather_entity.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  Future<WeatherEntity> fetchWeather(String city) async {
    final url = Uri.parse('$baseUrl?q=$city&appid=$weatherApiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return WeatherModel.fromJson(jsonData);
    } else {
      throw Exception('City not found');
    }
  }
}
