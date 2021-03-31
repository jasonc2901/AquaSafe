import 'dart:io';
import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/models/BarChartModel.dart';
import 'package:FinalYearProject/view/route_page.dart';
import 'package:FinalYearProject/widgets/LiffeyGraphWiget.dart';
import 'package:FinalYearProject/widgets/NI_Rivers_Graph.dart';
import 'package:FinalYearProject/widgets/ROI_Rivers_Graph.dart';
import 'package:FinalYearProject/widgets/ShannonGraphWidget.dart';
import 'package:FinalYearProject/widgets/liffey_main_data.dart';
import 'package:FinalYearProject/widgets/shannon_river_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TrendsPage extends StatefulWidget {
  final FirebaseUser user;

  const TrendsPage(
    this.user,
  );

  @override
  _TrendsPageState createState() => _TrendsPageState();
}

class _TrendsPageState extends State<TrendsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
          Container(
            height: size.height / 8,
            width: size.width,
            decoration: BoxDecoration(
              color: waterBlueColour,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36.0),
                bottomRight: Radius.circular(36.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Statistical Analysis",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: NIRiversGraph(),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ROIRiversGraph(),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LiffeyGraphWidget(),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ShannonGraphWidget(),
          )
        ]));
  }
}
