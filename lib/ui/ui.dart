import 'package:apis/models/model.dart';
import 'package:apis/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class UI extends StatefulWidget {
  const UI({Key? key}) : super(key: key);

  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  StreamController sController = StreamController();
  late Stream stream = sController.stream;
  late StreamSubscription subscription;
  OpenWeather? theData;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    subscription = stream.listen((event) async {
      if (event.toString().isNotEmpty) {
        var data = await Client.weatherCall(event.toString());
        setState(() {
          theData = data;
        });
        print(theData!.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(theData);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color(0XFF232452),
          title: const Text('Weather Forecast'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 150,
                child: TextField(
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0XFFFDD053),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  sController.sink.add(controller.text);
                  controller.clear();
                },
                icon: const Icon(CupertinoIcons.search),
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0XFF11103A),
                Color(0XFF1C1C42),
                Color(0XFF232452),
                Color(0XFF2F2D52),
              ],
            ),
          ),
          child: theData == null
              ? const SizedBox.shrink()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Today'),
                        Text(DateFormat.yMMMMEEEEd()
                            .format(DateTime.now())
                            .toString()),
                        // Text('${theData!.temperature.toString()}°C'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        
                        Text('${theData!.temperature.toString()}°C'),
                        Image.network(
                      'http://openweathermap.org/img/wn/${theData!.icon}@2x.png',
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                      ],
                    ),
                    
                    Text(
                      theData!.description,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(theData!.temperature.toString()),
                    Text("${theData!.name}, ${theData!.country}")
                  ],
                ),
        ));
  }
}
