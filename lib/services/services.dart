import 'package:apis/models/model.dart';
import 'package:http/http.dart' as http;

class Client {
  static  Future<OpenWeather>weatherCall(location) async {
      var url = Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=$location&appid=5c739e5716255a89efbe703f182f8ea9&units=metric');
      http.Response data = await http.get(url);
      var response = OpenWeather.fromJson(data.body);
      // print(response);
      
      return response;
   
  }
}
