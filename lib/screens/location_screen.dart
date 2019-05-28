import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({@required this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  String weatherIcon;
  String weatherMsg;
  int temperature;
  int condition;
  String cityName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationWeather();
  }

  void getLocationWeather() async {
    updateUi(widget.locationWeather);
  }

  void updateUiDummyData(dynamic weatherData) {
    setState(() {
      try {
        var temp = weatherData['main']['temp'];
        temperature = temp.toInt();
      } on Exception catch (e) {
        temperature = weatherData['main']['temp'];
      }
      var condition = weatherData['weather'][0]['id'];

//      temperature = 15;
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMsg = weatherModel.getMessage(temperature);
      cityName = weatherData['name'];

      print(temperature);
    });
  }

  void updateUi(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMsg = 'Unable to fetch the location';
        cityName = '';
        return;
      }
      try {
        var temp = weatherData['main']['temp'];
        temperature = temp.toInt();
      } on Exception catch (e) {
        temperature = weatherData['main']['temp'];
      }
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMsg = weatherModel.getMessage(temperature);
      cityName = weatherData['name'];

      print(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );

                      print(result);
                      if (result != null) {
                        var weatherData =
                            await weatherModel.getCityWeather(result);
                        updateUi(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temperature.toString(),
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMsg in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//  void _navigateAndPushCityScreen() async {
//    final result = await Navigator.push(
//      context,
//      MaterialPageRoute(
//        builder: (context) {
//          return CityScreen();
//        },
//      ),
//    );
//
//    print(result);
//    Scaffold.of(context)
//      ..removeCurrentSnackBar()
//      ..showSnackBar(
//        SnackBar(
//          content: Text('$result'),
//        ),
//      );
//  }
}
