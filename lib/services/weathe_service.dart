import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../model/weather_model.dart';
class WeatherService {
  static const BASE_URL = "http://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async{
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
    if(response.statusCode == 200){
      return Weather.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Khong Tim Thay Du Lieu');
    }
  }
  Future<String> getCurrentCity() async {
    // xin phep nguoi dung
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }
    // lay vi tri hien tai
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // chuyen doi vi tri thanh danh sach cac doi tuong danh dau vi tri
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    // trich xuat ten thanh pho tu vi tri dau tien
    String? city = placemarks[0].locality;
    return city ?? "";
  }
}