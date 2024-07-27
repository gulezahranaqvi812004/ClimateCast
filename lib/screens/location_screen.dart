import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late String weatherIcon = "";
  late String cityName = "";
  late String message = "";
  late int temperature = 0;

  void updateUI(dynamic weatherData) {
    setState(() {
      double tempK = weatherData['main']['temp'];
      temperature = tempK.toInt(); // Convert Kelvin to Celsius

      var condition = weatherData['weather'][0]['id'];
      print("Weather condition is $temperature");
      cityName = weatherData['name'];
      message = weather.getMessage(temperature);
      weatherIcon = weather.getWeatherIcon(condition);
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      home: Scaffold(
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
                    TextButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                          color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return CityScreen();
                            }));
                        if (typedName != null) {
                          var weatherData = await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                        print(typedName);
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  '$temperature°',
                                  style: kTempTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  weatherIcon,
                                  style: kConditionTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            '$message in $cityName',
                            textAlign: TextAlign.center,
                            style: kMessageTextStyle,
                          ),
                        ),
                      ],
                    ),
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
