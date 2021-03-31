import 'package:flutter/material.dart';

import '../constants.dart';

class UnitConverterPage extends StatefulWidget {
  final conversion;

  const UnitConverterPage(this.conversion);

  @override
  _UnitConverterPageState createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  bool showResponse = false;
  TextEditingController valueToConvert = new TextEditingController();
  String convertedVal = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 5.0,
        title: Text("Unit Converter",
            style: TextStyle(color: Colors.white, fontSize: 30)),
        backgroundColor: waterBlueColour,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: widget.conversion == 'miles'
                //if the choice is miles to km
                ? Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 4,
                                color: Colors.grey.withOpacity(0.7),
                                offset: Offset(0, 2),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          width: size.width,
                          height: size.height / 1.3,
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Miles to Kilometres",
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: waterBlueColour,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 4,
                                        color: Colors.grey.withOpacity(0.7),
                                        offset: Offset(0, 2),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  width: size.width,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            "Enter the Number of Miles",
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(26.0),
                                        child: Container(
                                          width: size.width,
                                          child: TextField(
                                            controller: valueToConvert,
                                            decoration: new InputDecoration(
                                              hintText: "miles",
                                              hintStyle: TextStyle(
                                                  color: Colors.black),
                                              fillColor: Colors.grey[300],
                                              filled: true,
                                              border: new OutlineInputBorder(
                                                borderSide: new BorderSide(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      RaisedButton(
                                        color: Colors.grey[300],
                                        onPressed: () {
                                          if (valueToConvert.text.length > 0) {
                                            convertMilesToKm(
                                                valueToConvert.text);
                                          }
                                        },
                                        child: Text('Convert'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              showResponse == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: waterBlueColour,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25.0)),
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 4,
                                              color:
                                                  Colors.grey.withOpacity(0.7),
                                              offset: Offset(0, 2),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                        width: size.width,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  '${valueToConvert.text.toString()} miles in kilometres',
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(26.0),
                                              child: Container(
                                                width: size.width,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300]),
                                                child: Center(
                                                  child: Text(
                                                    "$convertedVal km",
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                //if the choice is cm to m
                : Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 4,
                                color: Colors.grey.withOpacity(0.7),
                                offset: Offset(0, 2),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          width: size.width,
                          height: size.height / 1.3,
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Centimetres to Metres",
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: waterBlueColour,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 4,
                                        color: Colors.grey.withOpacity(0.7),
                                        offset: Offset(0, 2),
                                        blurRadius: 3,
                                      ),
                                    ],
                                  ),
                                  width: size.width,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            "Enter the Number of Centimetres",
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(26.0),
                                        child: Container(
                                          width: size.width,
                                          child: TextField(
                                            controller: valueToConvert,
                                            decoration: new InputDecoration(
                                              hintText: "cm",
                                              hintStyle: TextStyle(
                                                  color: Colors.black),
                                              fillColor: Colors.grey[300],
                                              filled: true,
                                              border: new OutlineInputBorder(
                                                borderSide: new BorderSide(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      RaisedButton(
                                        color: Colors.grey[300],
                                        onPressed: () {
                                          if (valueToConvert.text.length > 0) {
                                            convertCmToMetres(
                                                valueToConvert.text);
                                          }
                                        },
                                        child: Text('Convert'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              showResponse == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: waterBlueColour,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25.0)),
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 4,
                                              color:
                                                  Colors.grey.withOpacity(0.7),
                                              offset: Offset(0, 2),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                        width: size.width,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  '${valueToConvert.text.toString()} cm in metres',
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(26.0),
                                              child: Container(
                                                width: size.width,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300]),
                                                child: Center(
                                                  child: Text(
                                                    "$convertedVal m",
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
      ),
    );
  }

  //method to convert miles to km
  void convertMilesToKm(String val) {
    int miles = int.parse(val);

    double km = miles * 1.609;
    setState(() {
      showResponse = true;
      convertedVal = km.toString();
    });
  }

  //method to convert cm to m
  void convertCmToMetres(String val) {
    int cm = int.parse(val);

    double metres = cm / 100;

    setState(() {
      showResponse = true;
      convertedVal = metres.toString();
    });
  }
}
