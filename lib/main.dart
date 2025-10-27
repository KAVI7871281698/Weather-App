import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/repositories/weather_repository.dart';
import 'domain/usecases/get_weather_usecase.dart';
import 'presentation/viewmodels/weather_viewmodel.dart';
import 'presentation/screens/weather_screen.dart';

void main() {
  final repository = WeatherRepository();
  final getWeatherUseCase = GetWeatherUseCase(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherViewModel(getWeatherUseCase),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Clean App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherScreen(),
    );
  }
}
