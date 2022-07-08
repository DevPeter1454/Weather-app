import 'package:apis/models/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Client {
  static  weatherCall(location) async {
    var url = Uri.parse(
        'https://community-open-weather-map.p.rapidapi.com/forecast?q=$location&units=metric');
    http.Response data = await http.get(url, headers: {
      "X-RapidAPI-Host": "community-open-weather-map.p.rapidapi.com",
      "X-RapidAPI-Key": "09933e17damshecfbd3c4d0c0649p18b94ajsnce8f6dc15c72"
    });
    var retrievedData = json.decode(data.body);
    List<OpenWeather> list = [];
    
    for (var i = 0; i < retrievedData['list'].length; i++) {
      list.add(OpenWeather(cloud: retrievedData['list'][i]['weather'][0]['main'], description: retrievedData['list'][i]['weather'][0]['description'], icon: retrievedData['list'][i]['weather'][0]['icon'], temperature: retrievedData['list'][i]['main']['temp'],date: DateTime.fromMillisecondsSinceEpoch(retrievedData['list'][i]['dt'] * 1000)));

    }
  var infos = {'list': list, 'others': retrievedData['city']};
//  
    return infos;

    // return response;
  }
}
