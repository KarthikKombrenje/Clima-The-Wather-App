import 'dart:convert';

import 'package:clima/services/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants1.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
WeatherModel o = WeatherModel();
class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});//yow will be passed WeatherData variable (it contains the info of the weather retrieived frm the http api url) (WeatherData of the loading_Screen).
  final locationWeather;//LocationWeather receives the information
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  double temp;
  String weatherIcon;
  int condition;
  String cityName;
  String weatherMessage;
  @override
  void initState(){

    super.initState();
    updateUi(widget.locationWeather);
}
  void updateUi(dynamic weatherData)
  {
    setState(() {

      if(weatherData==null)
      {
        temperature=0;
        weatherIcon = 'Error';
        cityName ='';
        weatherMessage= 'Unable to get weather data';
        return;
      }
      var condition = weatherData['weather'][0]['id'];//api contains id eg 300 for light drizzle and so on
      temp = weatherData['main']['temp'];
      temperature=temp.toInt();
      cityName = weatherData['name'];//get the cityNmae from the json in the api
      weatherMessage = weather.getMessage(temperature);//call the getMessage method from weather.dart and the print the respective message according to the temperature at your place at the moment
      weatherIcon =weather.getWeatherIcon(condition);//pass that condition to a method in getWeatherdata
      print(temperature);
    });
  }
  Future<void> getLocation()
  async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
  }
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
                      var weatherData = await weather.getLocationWeather();//we need to gaurantee that this wont return null as it will take long time to execute
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(            //From the city_screen we get the cityName popped back when the user clicks the getWeather but in the city_)screen.dart
                    onPressed: () async {//here we are adding await as we hv to pass the city the user entered to the previous screen CityScreen in city_Screen.dart.We dont know when the user is going to type the data so we use await and async
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      },),);
                      print(typedName);//print the name that you typed in the search box i.e print the cityName passed from the city_Screen.dart which has been saved in the variable typedName
                      if(typedName!=null)
                        {
                          var weatherData = await weather.getCityWeather(typedName);
                          print(weatherData);//pass the cityName i.e is typedName that contains the cityNmae to the getWeather
                          updateUi(weatherData);//Call this method to get temperature weather condition(sunny ,rainy)etc.These will be stored in the variables there
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
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon ,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "${o.getMessage(temperature)} in $cityName!",//
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
}


