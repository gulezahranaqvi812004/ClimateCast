import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
const APIKey='534585732fd2eb94f615541b108b85de';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }
  void getLocationData() async {
    Location location=Location();
    await location.getCurrentLocation();

    print(location.longitude);
    print(location.latitude);
    setState(() {
      latitude=location.latitude;
      longitude=location.longitude;
    });
    final url='https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$APIKey';
    NetworkHelper networkHelper=NetworkHelper(url);
    var weatherData=await networkHelper.getData();
    print(weatherData);
    
    Navigator.push(context, MaterialPageRoute(builder: (context){
     return LocationScreen(
       locationWeather: weatherData,
     );
    }));
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child:  SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
