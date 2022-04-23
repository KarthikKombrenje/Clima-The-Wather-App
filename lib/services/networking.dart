import 'package:http/http.dart' as http;
import 'dart:convert';
class NetworkHelper {
  NetworkHelper(this.url);
  var url;
  Future getData() async {
    //var url = Uri.parse(url);
    //var url = Uri.parse('api.openweathermap.org/data/2.5/weather?q=London&appid=92e463e61258ef5a8b9a9bd11733b62c');
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
var decodedData = jsonDecode(data);
print(decodedData);
return decodedData;
    }
    else {
      print(response.statusCode);
    }
  }
}