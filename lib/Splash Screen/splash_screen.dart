
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studio_booking_app/OnBoarding/on_boarding.dart';

class SplashScreen extends StatefulWidget {
/*  static String routeName = "/splash";
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);*/

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 5;


  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => OnBoarding()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height,
        decoration:  BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey.shade300,
                Colors.white,
          /*      Color(0xff000080),
                Color(0xff104FE4),*/
              ],
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.2,),
              Image.asset("assets/images/logo.png"),
              SizedBox(height: MediaQuery.of(context).size.height*0.15,),
              Image.asset("assets/images/texts2.png"),
            ],
          ),
        ),

      ),
    );
  }
}
