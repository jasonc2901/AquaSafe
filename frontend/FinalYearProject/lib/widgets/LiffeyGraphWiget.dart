import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'liffey_main_data.dart';

class LiffeyGraphWidget extends StatefulWidget {
  LiffeyGraphWidget({Key key}) : super(key: key);

  @override
  _LiffeyGraphWidgetState createState() => _LiffeyGraphWidgetState();
}

class _LiffeyGraphWidgetState extends State<LiffeyGraphWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: size.height / 2,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            boxShadow: [
              BoxShadow(
                spreadRadius: 4,
                color: Colors.grey.withOpacity(0.7),
                offset: Offset(0, 2),
                blurRadius: 3,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("River Liffey Ammonia Levels",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Color(0xff20262f),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 4,
                          color: Colors.grey.withOpacity(0.7),
                          offset: Offset(0, 2),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LineChart(
                        LiffeyMainData.liffeyMainData(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
