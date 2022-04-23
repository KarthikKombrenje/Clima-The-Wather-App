
import 'package:flutter/material.dart';//When u first run the app execution starts from here
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import'package:clima/services/weather.dart';
const APIkey = '9f2e463e61258ef5a8b9a9bd11733b62c';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
double MyMarginAsDouble;
double latitude,longitude;
class _LoadingScreenState extends State<LoadingScreen> {
void initState(){//if i call getlocation inside init method it automatically gets the location without the need of a button
  super.initState();
  getLocationData();
}

  Future<void> getLocationData()
async {
  WeatherModel weatherModel = WeatherModel();
  var weatherData = await weatherModel.getLocationWeather();
  if (weatherData != null) {//the api information passed must not be null
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }
}
@override
Widget build(BuildContext context) {//buffering screen
  return Scaffold(
    body:Center(
      child:SpinKitDoubleBounce(//to provide animation that screen is loading we use spinkit
        color:Colors.white,
        size:100,
      )
    )
  );
}
}
