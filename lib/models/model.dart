import 'dart:convert';

class OpenWeather {
  final String cloud;
  final String description;
  final String icon;
  final double temperature;
  final String name;
  final String country;

  OpenWeather({
    required this.cloud,
    required this.description,
    required this.icon,
    required this.temperature,
    required this.name,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'cloud': cloud});
    result.addAll({'description': description});
    result.addAll({'icon': icon});
    result.addAll({'temperature': temperature});
    result.addAll({'name': name});
    result.addAll({'name': country});

    return result;
  }

  factory OpenWeather.fromMap(Map<String, dynamic> data) {
    return OpenWeather(
      cloud: data['weather'][0]['main'] ?? '',
      description: data['weather'][0]['description'] ?? '',
      icon: data['weather'][0]['icon'] ?? '',
      temperature: data['main']['temp'] ?? '',
      name: data['name'] ?? '',
      country: data['sys']['country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OpenWeather.fromJson(String source) =>
      OpenWeather.fromMap(json.decode(source));
}
