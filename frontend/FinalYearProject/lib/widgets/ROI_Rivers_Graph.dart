import 'package:FinalYearProject/constants.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ROIRiversGraph extends StatefulWidget {
  ROIRiversGraph({Key key}) : super(key: key);

  @override
  _ROIRiversGraphState createState() => _ROIRiversGraphState();
}

class _ROIRiversGraphState extends State<ROIRiversGraph> {
  Map<String, double> roi_data = {
    "High": 7,
    "Good": 30,
    "Moderate": 18,
    "Poor": 19,
    "Bad": 1
  };
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 2.3,
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
                  child: Text("Republic of Ireland Overall River Quality",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
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
                  child: PieChart(
                    dataMap: roi_data,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    colorList: [
                      Color.fromRGBO(0, 112, 255, 1),
                      Color.fromRGBO(76, 204, 0, 1),
                      Color.fromRGBO(255, 255, 0, 1),
                      Color.fromRGBO(230, 152, 0, 1),
                      Color.fromRGBO(255, 0, 0, 1),
                    ],
                    initialAngleInDegree: 0,
                    ringStrokeWidth: 32,
                    centerText: "River Quality",
                    legendOptions: LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: false,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
