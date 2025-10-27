import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/weather_viewmodel.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WeatherViewModel>();
    final controller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(176, 4, 234, 1), // fixed RGBO syntax
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🌤 Title
                const Text(
                  'Weather App',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Check weather by city 🌦️',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),

                // 🔍 Search Box
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: controller,
                    textInputAction: TextInputAction.search, // 🔹 Changes keyboard button to "Search"
                    onSubmitted: (value) {
                      // 🔹 Called when user presses "Enter" or "Search"
                      FocusScope.of(context).unfocus();
                      viewModel.loadWeather(value.trim());
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter city name (e.g. Coimbatore)',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search, color: Colors.deepPurple),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          viewModel.loadWeather(controller.text.trim());
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // 🌡 Weather Info Section
                if (viewModel.isLoading)
                  const CircularProgressIndicator(color: Colors.deepPurple)
                else if (viewModel.error != null)
                  Text(
                    viewModel.error!,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  )
                else if (viewModel.weather != null)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 🌍 City
                        Text(
                          viewModel.weather!.city,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // 🌡 Temperature
                        Text(
                          '${viewModel.weather!.temperature}°C',
                          style: const TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // 🌤 Condition
                        Text(
                          viewModel.weather!.condition,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 💧 Humidity & 🌬 Wind
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.water_drop, color: Colors.deepPurple),
                            const SizedBox(width: 6),
                            Text(
                              'Humidity: ${viewModel.weather!.humidity}%',
                              style: const TextStyle(fontSize: 10),
                            ),
                            const SizedBox(width: 20),
                            const Icon(Icons.air, color: Colors.deepPurple),
                            const SizedBox(width: 6),
                            Text(
                              'Wind: ${viewModel.weather!.windSpeed} m/s',
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                else
                  const Text(
                    'Enter a city name to get the weather ☀️',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
