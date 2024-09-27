import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/services/weathe_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('d162b0ffdda3a833870fb4a78786ca04');
  Weather? _weather;
  //fetch weather
  _fetchWeather() async{
    // lay thanh pho hien tai
    String cityName = await _weatherService.getCurrentCity();
    //lay thoi tiet cho thanh pho do
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }catch(e){
      print(e);
    }
  }
  // init state
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city..."),
            Text('${_weather?.temperature.toString()}°C'),
          ],
        ),
      ),
    );
  }
}
