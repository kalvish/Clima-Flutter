import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const String API_KEY = '6e6845257cd95a7d0bbf897094f1286c';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double lat;
  double lon;

  void getLocation() async {
    Location location = await Location().geoLocation();
    print(location.latitude.toString() + ',' + location.longitude.toString());
    lat = location.latitude;
    lon = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$API_KEY&units=metric');

    var data = await networkHelper.getData();
//    double temp = jsonDecode(data)['main']['temp'];
//    print(data);
//    String description = jsonDecode(data)['weather'][0]['description'];
//    print(description);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(
          locationWeather: data,
        );
      }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitRing(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }
}
