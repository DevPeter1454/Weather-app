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
  dynamic theData;
  List<OpenWeather>? weatherList;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    subscription = stream.listen((event) async {
      if (event.toString().isNotEmpty) {
        var data = await Client.weatherCall(event.toString());
        setState(() {
          theData = data;
          weatherList = data['list'];
        });
        print(theData!);
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
        body: Column(
          children: [
            Expanded(
              child: Container(
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
                          Container(
                            // alignment: Alignment.,
                              width: 380,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                // color: Colors.white,
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors:[
                                
                                    Color(0XFF2A294B),
                                    Color(0XFF2A294B),
                                    Color(0XFF2A294B),
                                    Color(0XFF2A294B),
                                    Color(0XFF2A294B),
                                  ]
                                )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // Text('Today'),
                                      Text(DateFormat.yMMMMEEEEd().format(weatherList![0].date )),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                          '${weatherList![0].temperature.toString()}°C'),
                                      Image.network(
                                        'http://openweathermap.org/img/wn/${weatherList![0].icon}@2x.png',
                                       
                                      ),
                                      //
                                    ],
                                  ),
                                  Text('${theData!['others']['name']}'
                                      .toString()),
                                ],
                              ))
                        ],
                      ),
              ),
            ),
          ],
        ));
  }
}
