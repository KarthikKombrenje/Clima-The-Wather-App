
import 'package:geolocator/geolocator.dart';

class location{
  double latitude;
  double longitude;
  Future  getCurrentLocation()
  async {
    try{
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low); //high is battery consuming
      LocationPermission permission1 = await Geolocator.checkPermission();
      latitude=position.latitude;
      longitude=position.longitude;
    }
    catch(e)
    {
      print(e);
    }
  }

}