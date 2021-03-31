import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/view/make_a_difference.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  FAQPage({Key key}) : super(key: key);

  @override
  _OurDataPageState createState() => _OurDataPageState();
}

class _OurDataPageState extends State<FAQPage> {
  String firstQuestion =
      "Our data comes from the Northern Ireland NIEA and Environmental Protection Agency for Ireland. We abstract this information, store it and then present it to the public.";
  String secondQuestion =
      "Our goal with this application is to provide the public with vital information regarding water polllution data. We realise that this information isn't currently readily available, we want to change that!";
  String thirdQuestion =
      "We go by the name of Fsociety, we are a two man team that have a passion for developing tools that can make a difference. We are always looking to expand our skills as developers and always looking for the next project.";
  String fourthQuestion =
      "Everyone can get involved in the clean-up process of water bodies. It is an ever increasing problem and change is required to save our waters. Why not sign up to our save water bodies program?";
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 5.0,
        title: Text("FAQ", style: TextStyle(color: Colors.white, fontSize: 30)),
        backgroundColor: waterBlueColour,
      ),
      body: ListView(children: [
        SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: screenWidth,
            height: screenHeight / 1.6,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Where we get our data?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  firstQuestion,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("What is our goal?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(secondQuestion, style: TextStyle(fontSize: 15)),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("A little about us",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(thirdQuestion, style: TextStyle(fontSize: 15)),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("How can you make a difference?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(fourthQuestion, style: TextStyle(fontSize: 15)),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}
