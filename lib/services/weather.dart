import '../location.dart';
import 'networking.dart';
import 'package:clima/screens/city_screen.dart';
class WeatherModel {

  Future<dynamic> getCityWeather(String cityName)
  async {
    var url ='http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=92e463e61258ef5a8b9a9bd11733b62c&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();//get the data from the http call present in the networking.dart.We need to wait till we get the data so add await
    return weatherData;
    print(weatherData);
  }

  Future<dynamic> getLocationWeather()
  async {
    location ob= new location();
    await ob.getCurrentLocation();
    print(ob.latitude);
    print(ob.longitude);
    //calling networkHelper
    NetworkHelper networkHelper = NetworkHelper('http://api.openweathermap.org/data/2.5/weather?lat=${ob.latitude}&lon=${ob.longitude}&appid=92e463e61258ef5a8b9a9bd11733b62c&units=metric');
    var WeatherData = await networkHelper.getData();
    return WeatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}