import 'package:flutter/material.dart';
import 'package:clima/utilities/constants1.dart';
//import 'location_screen.dart';
String cityName;
class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style:TextStyle(
                    color:Colors.black87,
                  ),
                  decoration:kTextFieldInputDecoration,//how the text field shld look and also hint text design
                  onChanged:(value){//pass whatever is written in the text Field value is already defined inside on Changed ..in built variable that contains the letters u typed in the textBox
                    cityName = value;
                  },
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context,cityName);//this sends the cityName back to the LocationScreen class/context in (location_screen.dart)
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}