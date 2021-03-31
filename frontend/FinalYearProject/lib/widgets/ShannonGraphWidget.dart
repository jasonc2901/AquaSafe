import 'package:FinalYearProject/widgets/shannon_river_main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ShannonGraphWidget extends StatefulWidget {
  ShannonGraphWidget({Key key}) : super(key: key);

  @override
  _ShannonGraphWidgetState createState() => _ShannonGraphWidgetState();
}

class _ShannonGraphWidgetState extends State<ShannonGraphWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: size.height / 2.1,
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("River Shannon Total Oxidised Nitrogen",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Container(
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
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LineChart(
                      ShannonMainData.shannonMainData(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
