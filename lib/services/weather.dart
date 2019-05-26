import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const String API_KEY = '6e6845257cd95a7d0bbf897094f1286c';
const String URL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  double lat;
  double lon;

  Future<dynamic> getLocationWeather() async {
    Location location = await Location().geoLocation();
    print(location.latitude.toString() + ',' + location.longitude.toString());
    lat = location.latitude;
    lon = location.longitude;

    NetworkHelper networkHelper =
        NetworkHelper('$URL?lat=$lat&lon=$lon&appid=$API_KEY&units=metric');

    var data = await networkHelper.getData();
    return data;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
