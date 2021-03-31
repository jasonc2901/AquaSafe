import 'dart:io';
import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/view/route_page.dart';
import 'package:FinalYearProject/view/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomeBack extends StatefulWidget {
  final FirebaseUser user;

  const WelcomeBack(
    this.user,
  );

  @override
  _WelcomeBackState createState() => _WelcomeBackState();
}

class _WelcomeBackState extends State<WelcomeBack> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            apptitle,
            style: TextStyle(fontSize: 25),
          ),
          backgroundColor: waterBlueColour,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              height: size.height / 1.8,
              decoration: BoxDecoration(
                  color: waterBlueColour,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 10,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75)),
                  ],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(65.0),
                      bottomRight: Radius.circular(65.0))),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 60),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(widget.user.photoUrl),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    "Welcome Back, " + widget.user.displayName,
                    style: TextStyle(
                      fontSize: 45.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 70.0),
            Container(
              width: 170,
              height: 50,
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RoutePage(widget.user)));
                },
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                color: waterBlueColour,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: 170,
              height: 50,
              child: FlatButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomePage()));
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                color: Colors.red[400],
              ),
            ),
          ],
        ));
  }
}
