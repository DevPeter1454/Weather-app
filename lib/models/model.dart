import 'dart:convert';

class OpenWeather {
  final String cloud;
  final String description;
  final String icon;
  final double temperature;
  final DateTime date;

  OpenWeather({
    required this.cloud,
    required this.description,
    required this.icon,
    required this.temperature,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'cloud': cloud});
    result.addAll({'description': description});
    result.addAll({'icon': icon});
    result.addAll({'temperature': temperature});
    result.addAll({'date': date.millisecondsSinceEpoch});
  
    return result;
  }

 
factory OpenWeather.fromMap(Map<String, dynamic> map) {
    return OpenWeather(
      cloud: map['weather'][0]['main'] ?? '',
      description: map['weather'][0]['description'] ?? '',
      icon: map['weather'][0]['icon'] ?? '',
      temperature: map['main']['temp']?.toDouble() ?? 0.0,
      date: DateTime.fromMillisecondsSinceEpoch(map['dt']),
    );
  }
  String toJson() => json.encode(toMap());

  factory OpenWeather.fromJson(String source) =>
      OpenWeather.fromMap(json.decode(source));

  
}
