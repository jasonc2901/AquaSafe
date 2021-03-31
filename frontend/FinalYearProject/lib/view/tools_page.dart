import 'package:FinalYearProject/constants.dart';
import 'package:FinalYearProject/widgets/activities_widget.dart';
import 'package:FinalYearProject/widgets/conversion_widget.dart';
import 'package:FinalYearProject/widgets/phscale_widget.dart';
import 'package:FinalYearProject/widgets/qvalue_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ToolsPage extends StatelessWidget {
  final FirebaseUser user;

  const ToolsPage(
    this.user,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Container(
      color: Colors.white,
      child:
          ListView(scrollDirection: Axis.vertical, shrinkWrap: true, children: [
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
                "Convert units and more info on pollution data",
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
        ConverterWidget(),
        QValueWidget(),
        PHScaleWidget(),
        ActivitiesWidget()
      ]),
    );
  }
}
