import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
                          
      backgroundColor: Color(0XFF1C1C42),
      body: Center(child: SpinKitCircle(color: Colors.white, size:50.0),)
    );
  }
}