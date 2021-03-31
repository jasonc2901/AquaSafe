import 'dart:async';
import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/view/welcome_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3, milliseconds: 500),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => WelcomePage())));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: waterBlueColour,
      body: Center(
          child: Image.asset(
        'assets/water_droplet.gif',
        height: 450,
        width: 250,
      )),
    );
  }
}
