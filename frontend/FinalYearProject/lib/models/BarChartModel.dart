import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class BarChartModel {
  String title;
  String year;
  double ammoniaLevels;
  final charts.Color color;

  BarChartModel({
    this.title,
    this.year,
    this.ammoniaLevels,
    this.color,
  });
}
