import 'package:apis/models/model.dart';
import 'package:apis/services/services.dart';
import 'package:apis/ui/loading.dart';
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
  String error = 'No matching data found';
  List<OpenWeather>? weatherList;
  List today = [];
  List rest = [];
  bool loading = false;
  TextEditingController controller = TextEditingController();
  ScrollController scroller = ScrollController();

  @override
  void initState() {
    super.initState();
    subscription = stream.listen((event) async {
      if (event.toString().isNotEmpty) {
        setState(() {
          loading = true;
        });
        var data = await Client.weatherCall(event.toString());
        setState(() {
          // print('data: $data');
          if (data != null) {
            theData = data;
            weatherList = data['list'];
            // print(weatherList);
            for (var i = 0; i < weatherList!.length; i++) {
              if (DateFormat.yMEd().format(weatherList![i].date) ==
                  DateFormat.yMEd().format(weatherList![0].date)) {
                today.add(weatherList![i]);
              } else {
                rest.add(weatherList![i]);
              }
            }
            print(today);
            print(rest);
            loading = false;
          } else {
            theData = error;
            loading = false;
          }
        });
        // print('theData $theData');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(theData);
    return loading
        ? const Loading()
        : Scaffold(
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
                    width:  MediaQuery.of(context).size.width,
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
                        : theData == error
                            ? const Center(child: Text('City not found'))
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        // alignment: Alignment.,
                                        width: 380,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            // color: Colors.white,
                                            gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0XFF2A294B),
                                                  Color(0XFF2A294B),
                                                  Color(0XFF2A294B),
                                                  Color(0XFF2A294B),
                                                  Color(0XFF2A294B),
                                                ])),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                // Text('Today'),
                                                Text(DateFormat.yMMMMEEEEd()
                                                    .format(
                                                        weatherList![0].date)),
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
                                        )),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        controller: scroller,
                                        itemCount: today.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            constraints: BoxConstraints.tight(Size.fromWidth(300)),
                                            child: ListTile(
                                              minLeadingWidth: 50,
                                              // leading: Text(DateFormat.yMEd()
                                              //     .add_jm()
                                              //     .format(today[index].date)),
                                              title: Text('${today[0].temperature.toString()}°C'),
                                              trailing: CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage: NetworkImage(
                                                    'http://openweathermap.org/img/wn/${today[index].icon}@2x.png'),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: rest.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: Text(DateFormat.yMEd()
                                                .add_jm()
                                                .format(
                                                    rest[index].date)),
                                            trailing: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: NetworkImage(
                                                  'http://openweathermap.org/img/wn/${rest[index].icon}@2x.png'),
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ),
                  ),
                ),
              ],
            ));
  }
}
